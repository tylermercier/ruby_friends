require "#{File.dirname(__FILE__)}/twitter_user"

class Search
  def initialize(twitter_response, search_term)
    @search_term = search_term
    @sentiment = 0
    @tweets = twitter_response[:statuses].map do |tweet|
      tweet = TwitterUser.parse(tweet)
      @sentiment += tweet[:sentiment]
      tweet
    end
    @sentiment = @sentiment / @tweets.length
  end

  def to_json
    {
      search_term: @search_term,
      sentiment: @sentiment,
      statuses: @tweets
    }.to_json
  end
end
