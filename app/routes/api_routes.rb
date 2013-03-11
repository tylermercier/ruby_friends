class MyApp < Sinatra::Base
  post "/api/twitter_auth" do
    save_user_session(params[:authString])
    redirect "/api/feed"
  end

  post "/api/feed" do
    save_user_session(params[:authString])
    client = Authorization.twitter_client(@current_user)
    json_response Following.new(client.home_timeline)
  end

  get "/api/feed" do
    client = Authorization.twitter_client(@current_user)
    json_response Following.new(client.home_timeline)
  end

  get "/api/search" do
    client = Authorization.twitter_client(@current_user)
    search_term = params[:q] || 'moodyfriends'
    result = client.search(search_term)
    json_response search_term: search_term, statuses: Search.new(result)
  end

  def save_user_session(auth_string)
    user = User.parse_from_auth_string(auth_string)
    session[:user] = user
    @current_user = user
  end

  def json_response(object)
    content_type :json
    object.to_json
  end
end
