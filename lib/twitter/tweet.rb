class Tweet
  def self.parse(tweet)
    sentiment = Engine.analyze(tweet["text"])
    {
      tweet_id: tweet["id"],
      created_at: tweet["created_at"],
      profile_url: tweet["user"]["profile_image_url"],
      favorited: tweet["favorited"],
      retweeted: tweet["retweeted"],
      sentiment: sentiment[:sentiment],
      probability: sentiment[:probability],
      text: tweet["text"]
    }
  end
end
