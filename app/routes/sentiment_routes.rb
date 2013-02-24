class MyApp < Sinatra::Base
  get "/sentiment" do
    user = session[:user]
    client = user.twitter_client
    @tweets = client.home_timeline
    erb :feed
  end

  get "/feed" do
    # @sentiment = Sentimentalizer.analyze('This is a statement')
    user = session[:user]
    client = user.twitter_client

    content_type :json
    client.home_timeline.to_json
  end
end
