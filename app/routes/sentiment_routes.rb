class MyApp < Sinatra::Base
  get "/sentiment" do
    client = Authorization.twitter_client(@current_user)
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
    client = Authorization.twitter_client(@current_user)
    following = Following.new(client.home_timeline)
    content_type :json
    following.to_json
  end

  post "/api/feed" do
    user = User.parse_from_auth_string(params[:authString])
    session[:user] = user
    client = Authorization.twitter_client(user)
    following = Following.new(client.home_timeline)
    content_type :json
    following.to_json
  end

  post "/api/twitter_auth" do
    user = User.parse_from_auth_string(params[:authString])
    session[:user] = user
    redirect "/api/feed"
  end
end
