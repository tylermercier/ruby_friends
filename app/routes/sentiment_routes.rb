class MyApp < Sinatra::Base
  get "/api/search" do
    client = Authorization.twitter_client(@current_user)
    result = client.search params[:q]
    content_type :json
    { search_term: params[:q], statuses: Search.new(result)}.to_json
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
