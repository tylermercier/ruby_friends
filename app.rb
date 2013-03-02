RACK_ENV ||= ENV["RACK_ENV"] || "development"

require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"
require "active_record"
require "logger"
require "twitter"
require "./lib/sentiment/sentimentalizer"
require "./lib/twitter/following"
require "./lib/client_builder"
require "./lib/user_builder"
require "./lib/form_parser"

class MyApp < Sinatra::Base
  enable :sessions
  enable :logging
  set :session_secret, "secret key"

  configure do
    Dir.mkdir('log') if !File.exists?('log') || !File.directory?('log')
    ActiveRecord::Base.logger = Logger.new(File.open("log/#{RACK_ENV}.log", "a+"))
    ActiveRecord::Base.configurations = YAML.load_file('config/database.yml')
    ActiveRecord::Base.establish_connection(RACK_ENV)
  end

  configure :production do
    disable :dump_errors, :some_custom_option
  end

  before do
    content_type "text/html", :charset => "utf-8"
    @user = session[:user]
  end

  Dir["./app/helpers/*.rb"].each { |file| require file }
  Dir["./app/models/*.rb"].each { |file| require file }
  Dir["./app/routes/*.rb"].each { |file| require file }

  helpers do
    include Rack::Utils
    include AppHelper
  end

  get '/' do
    erb :home
  end
end
