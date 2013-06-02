class TwitterService < ServiceBase

  def token
    user.twitter_auth.token
  end

  def secret
    user.twitter_auth.secret
  end

  def uid
    user.twitter_auth.uid.to_i
  end

  def client
    @client ||= Twitter::Client.new(
      :oauth_token => token,
      :oauth_token_secret => secret
    )
  end

  def save(tweet)
    user.tweets.create(reference: tweet.id.to_s, content: tweet.text, posted_at: tweet.created_at)
  end

  def fetch
    client.home_timeline
  end

  def save?(tweet)
    tweet.user.id.to_i == uid && !user.tweets.where(reference: tweet.id.to_s).any?
  end

end
