require "#{File.dirname(__FILE__)}/tweet"

class TwitterUser
  def self.parse(tweet_data)
    tweet = Tweet.parse(tweet_data)
    {
      :twitter_id => tweet_data["user"]["id"],
      :name => tweet_data["user"]["name"],
      :screen_name => tweet_data["user"]["screen_name"],
      :profile_url => tweet_data["user"]["profile_image_url"],
      :sentiment => tweet[:sentiment],
      :source => "twitter",
      :tweets => [tweet]
    }
  end
end
