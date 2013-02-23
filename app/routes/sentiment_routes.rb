class MyApp < Sinatra::Base
  get "/sentiment" do
    # @sentiment = Sentimentalizer.analyze('This is a statement')
    user = session[:user]
    client = user.twitter_client

    content_type :json
    client.home_timeline.to_json
  end
end
