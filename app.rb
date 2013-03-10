RACK_ENV ||= ENV["RACK_ENV"] || "development"

require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"
require "active_record"
require "logger"
require "twitter"
require "./lib/neo_sentiment/engine"
require "./lib/sentiment/sentimentalizer"
require "./lib/twitter/following"

class MyApp < Sinatra::Base
  enable :sessions
  enable :logging
  set :session_secret, "secret key"

  configure :development do
    Dir.mkdir('log') if !File.exists?('log') || !File.directory?('log')
    ActiveRecord::Base.logger = Logger.new(File.open("log/#{RACK_ENV}.log", "a+"))
    ActiveRecord::Base.configurations = YAML.load_file('config/database.yml')
    ActiveRecord::Base.establish_connection(RACK_ENV)
  end

  configure :production do
    disable :dump_errors, :some_custom_option

    services = JSON.parse(ENV['VCAP_SERVICES'])
    postgresql_key = services.keys.select { |svc| svc =~ /postgres/i }.first
    postgresql = services[postgresql_key].first['credentials']

    ActiveRecord::Base.establish_connection(
      :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
      :host     => postgresql['hostname'],
      :username => postgresql['user'],
      :password => postgresql['password'],
      :database => postgresql['name'],
      :encoding => 'utf8'
    )
  end

  before do
    content_type "text/html", :charset => "utf-8"
    @current_user = session[:user]
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
