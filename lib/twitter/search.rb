require "#{File.dirname(__FILE__)}/twitter_user"

class Search
  def initialize(twitter_response)
    @tweets = twitter_response[:statuses].map do |tweet|
      TwitterUser.parse(tweet)
    end
  end

  def to_json
    @tweets.to_json
  end
end
