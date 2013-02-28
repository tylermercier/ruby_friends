class MyApp < Sinatra::Base
  get "/sentiment" do
    user = session[:user]
    client = ClientFactory.build_for_user(user)
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
    client = ClientFactory.build_for_user(session[:user])
    following = Following.new(client.home_timeline)
    content_type :json
    following.to_json
  end

  post "/api/feed" do
    client = ClientFactory.build_from_auth_string(params[:authString])
    following = Following.new(client.home_timeline)
    content_type :json
    following.to_json
  end
end
