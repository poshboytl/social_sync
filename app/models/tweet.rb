class Tweet < ActiveRecord::Base
  belongs_to :user


  def authentication
    user.authentications.where(provider: 'twitter').try(:first)
  end


end
