class WeiboService < ServiceBase
  def token
    user.weibo_auth.token
  end

  def expires_at
    user.weibo_auth.expires_at
  end


  def client
     @client ||= WeiboOAuth2::Client.new
     @client.get_token_from_hash({:access_token => token, :expires_at => expires_at}) if @client
     @client
  end

  def post(content)
    client.statuses.update content
  end

end
