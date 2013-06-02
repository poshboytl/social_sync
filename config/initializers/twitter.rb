Twitter.configure do |config|
  config.consumer_key = ENV['TWITTER_KEY_SYNC']
  config.consumer_secret = ENV['TWITTER_SECRET_SYNC']
end

module OpenSSL
  module SSL
    remove_const :VERIFY_PEER
  end
end

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
