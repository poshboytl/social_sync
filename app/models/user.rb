class User < ActiveRecord::Base
  has_many :authentications
  has_many :tweets

  accepts_nested_attributes_for :authentications

  def self.from_auth auth, user
    local_auth(auth) || create_auth(auth, user)
  end

  def self.local_auth auth
    Authentication.where(provider: auth[:provider], uid: auth[:uid]).try(:first).try(:user)
  end

  def self.create_auth auth, user
    if user
      user.authentications.create(provider: auth[:provider], uid: auth[:uid],
                                 token: auth[:credentials][:token], secret: auth[:credentials][:secret])
    else
      user = create!(name: auth[:info][:nickname],
              authentications_attributes: [
                Authentication.new(provider: auth[:provider], uid: auth[:uid],
                                   token: auth[:credentials][:token], secret: auth[:credentials][:secret], expires_at: auth[:credentials][:expires_at] || 0).attributes
              ])
    end
    user
  end

  def twitter_auth
    self.authentications.where(provider: 'twitter').try(:first)
  end

  def weibo_auth
    self.authentications.where(provider: 'weibo').try(:first)
  end


end
