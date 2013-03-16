class MyApp < Sinatra::Base
  post "/api/twitter_auth" do
    save_user_session(params)
    redirect "/api/feed"
  end

  post "/api/feed" do
    save_user_session(params)
    client = Authorization.twitter_client(@current_user)
    result = client.home_timeline(count: 200)
    json_response Following.new(result)
  end

  get "/api/feed" do
    client = Authorization.twitter_client(@current_user)
    result = client.home_timeline(count: 200)
    json_response Following.new(result)
  end

  get "/api/search" do
    client = Authorization.twitter_client(@current_user)
    search_term = params[:q] || 'moodyfriends'
    result = client.search(search_term, count: 200)
    json_response Search.new(result, search_term)
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
