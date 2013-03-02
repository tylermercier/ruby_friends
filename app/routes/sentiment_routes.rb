class MyApp < Sinatra::Base
  get "/sentiment" do
    user = session[:user]
    client = ClientBuilder.build(user)
    timeline = client.home_timeline
    @tweets = timeline.map do |tweet|
      user = tweet[:user][:screen_name]
      created_at = tweet[:created_at]
      text = tweet[:text]
      sentiment = Sentimentalizer.analyze(text)
      {
        user: user,
        created_at: created_at,
        text: text,
        sentiment: sentiment
      }
    end
    erb :feed
  end

  get "/api/feed" do
    client = ClientBuilder.build(session[:user])
    following = Following.new(client.home_timeline)
    content_type :json
    following.to_json
  end

  post "/api/feed" do
    user = UserBuilder.build(params[:authString])
    client = ClientBuilder.build(user)
    following = Following.new(client.home_timeline)
    content_type :json
    following.to_json
  end

  post "/api/auth" do
    user = UserBuilder.build(params[:authString])
    redirect "/api/feed"
  end
end
