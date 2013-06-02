namespace :backgound do
  desc "Fetch twitter and save to DB"
  task :fetch_tweets => :environment do
    User.find_each do |user|
      begin
        twitter_service = TwitterService.new user
        twitter_service.fetch.each do |tweet|
          twitter_service.save(tweet) if twitter_service.save?(tweet)
        end
      rescue
        next
      end
    end
  end

  desc "Send twitter from db to Weibo"
  task :send_weibo => :environment do
    Tweet.where(sent: false).find_each do |tweet|
      begin
        weibo_service = WeiboService.new tweet.user
        weibo_service.post tweet.content
        tweet.update_attributes(sent: true)
      rescue
        next
      end
    end
  end
end
