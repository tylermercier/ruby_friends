RACK_ENV ||= ENV["RACK_ENV"] || "development"

require "json"
require "sinatra"
require "sinatra/activerecord"

require "omniauth"
require "omniauth-twitter"
require "twitter"

require "./lib/neo_sentiment/engine"
require "./lib/twitter/following"
require "./lib/twitter/search"

class MyApp < Sinatra::Base
  enable :sessions
  enable :logging
  set :session_secret, "secret key"

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

  configure :development do
    Dir.mkdir('log') if !File.exists?('log') || !File.directory?('log')
    ActiveRecord::Base.logger = Logger.new(File.open("log/#{RACK_ENV}.log", "a+"))
    ActiveRecord::Base.configurations = YAML.load_file('config/database.yml')
    ActiveRecord::Base.establish_connection(RACK_ENV)
  end

  configure :production do
    db = URI.parse(ENV['DATABASE_URL'])
    ActiveRecord::Base.establish_connection(
      :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
      :host     => db.host,
      :port     => db.port,
      :username => db.user,
      :password => db.password,
      :database => db.path[1..-1],
      :encoding => 'utf8'
    )
  end

  Dir["./app/helpers/*.rb"].each { |file| require file }
  Dir["./app/models/*.rb"].each { |file| require file }
  Dir["./app/routes/*.rb"].each { |file| require file }

  helpers do
    include Rack::Utils
    include AppHelper
  end

  before do
    @current_user = session[:user]
  end

  get '/' do
    erb :home
  end
end
