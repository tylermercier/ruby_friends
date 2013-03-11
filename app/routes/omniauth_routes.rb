class MyApp < Sinatra::Base
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
