class Tweet
  def self.parse(tweet)
    sentiment = Sentimentalizer.analyze(tweet["text"])
    {
      :tweet_id => tweet["id"],
      :created_at => tweet["created_at"],
      :profile_url => tweet["user"]["profile_image_url"],
      :favorited => tweet["favorited"],
      :retweeted => tweet["retweeted"],
      :sentiment => sentiment[:sentiment] * sentiment[:probability],
      :text => tweet["text"]
    }
  end
end
