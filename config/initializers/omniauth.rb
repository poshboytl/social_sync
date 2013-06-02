Rails.application.config.middleware.use OmniAuth::Builder do
  provider :weibo, ENV['WEIBO_KEY_SYNC'], ENV['WEIBO_SECRET_SYNC']
  provider :twitter, ENV['TWITTER_KEY_SYNC'], ENV['TWITTER_SECRET_SYNC']
end
