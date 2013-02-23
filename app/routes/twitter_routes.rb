require 'json'
require 'omniauth'
require 'omniauth-twitter'

class MyApp < Sinatra::Base
  twitter_config = YAML.load_file("config/twitter.yml") rescue nil || {}
  key = ENV['CONSUMER_KEY'] || twitter_config['consumer_key']
  secret = ENV['CONSUMER_SECRET'] || twitter_config['consumer_secret']

  Twitter.configure do |config|
    config.consumer_key = key
    config.consumer_secret = secret
  end

  use OmniAuth::Builder do
    provider :twitter, key, secret
  end

  get '/auth/:provider/callback' do
    auth_hash = request.env['omniauth.auth']
    user = Authorization.authorize(auth_hash)
    session[:user] = user
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
