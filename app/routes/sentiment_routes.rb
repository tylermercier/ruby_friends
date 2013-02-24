class MyApp < Sinatra::Base
  get "/sentiment" do
    user = session[:user]
    client = user.twitter_client
    @tweets = client.home_timeline
    erb :feed
  end

  get "/feed" do
    time_block 'total time' do
      @sentiment = Sentimentalizer.analyze('This is a statement')
    end

    user = session[:user]
    client = user.twitter_client

    content_type :json
    @sentiment.to_json
  end
end
