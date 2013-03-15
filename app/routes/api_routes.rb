class MyApp < Sinatra::Base
  post "/api/twitter_auth" do
    save_user_session(params)
    redirect "/api/feed"
  end

  post "/api/feed" do
    save_user_session(params)
    client = Authorization.twitter_client(@current_user)
    json_response Following.new(client.home_timeline(count: 200))
  end

  get "/api/feed" do
    client = Authorization.twitter_client(@current_user)
    json_response Following.new(client.home_timeline(count: 200))
  end

  get "/api/search" do
    client = Authorization.twitter_client(@current_user)
    search_term = params[:q] || 'moodyfriends'
    result = client.search(search_term, count: 200)
    json_response search_term: search_term, statuses: Search.new(result)
  end

  def save_user_session(params)
    user = Authorization.authorize_form(params)
    session[:user] = user
    @current_user = user
  end

  def json_response(object)
    content_type :json
    object.to_json
  end
end
