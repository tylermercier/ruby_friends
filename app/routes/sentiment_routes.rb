class MyApp < Sinatra::Base
  get "/sentiment" do
    user = session[:user]
    client = user.twitter_client
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
    user = session[:user]
    client = user.twitter_client
    following = Following.parse(client.home_timeline)
    content_type :json
    following.to_json
  end

  post "/api/feed" do
    auth = FormParser.parse params[:authString]
    user = Authorization.authorize({
      "provider" => "twitter",
      "uid" => auth["user_id"],
      "info" => { "name" => auth["screen_name"] },
      "credentials" => {
        "token" => auth["oauth_token"],
        "secret" => auth["oauth_token_secret"]
      }
    })
    client = user.twitter_client
    following = Following.parse(client.home_timeline)
    content_type :json
    following.to_json
  end
end
