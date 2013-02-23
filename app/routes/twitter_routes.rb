require 'json'
require 'omniauth'
require 'omniauth-twitter'

class MyApp < Sinatra::Base
  twitter_config = YAML.load_file("config/twitter.yml") rescue nil || {}

  use OmniAuth::Builder do
    key = ENV['CONSUMER_KEY'] || twitter_config['consumer_key']
    secret = ENV['CONSUMER_SECRET'] || twitter_config['consumer_secret']
    provider :twitter, key, secret
  end

  get '/auth/:provider/callback' do
    auth_hash = request.env['omniauth.auth']

    @authorization = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
    if @authorization
      session[:user] = @authorization.user
    else
      user = User.new :name => auth_hash["info"]["name"]
      user.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
      user.save
      session[:user] = user
    end

    redirect "/"
  end

  get '/auth/failure' do
    erb "<h1>Authentication Failed:</h1><h3>message:<h3> <pre>#{params}</pre>"
  end

  get '/auth/:provider/deauthorized' do
    erb "#{params[:provider]} has deauthorized this app."
  end

  get '/protected' do
    throw(:halt, [401, "Not authorized\n"]) unless session[:authenticated]
    erb "<pre>#{request.env['omniauth.auth'].to_json}</pre><hr>
         <a href='/logout'>Logout</a>"
  end

  get '/logout' do
    session[:user] = nil
    redirect '/'
  end
end
