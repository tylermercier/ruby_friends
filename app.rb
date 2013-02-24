RACK_ENV ||= ENV["RACK_ENV"] || "development"

require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"
require "active_record"
require "logger"
require "twitter"
require "./lib/sentiment/sentimentalizer"

def ask(msg, &block)
  puts block.inspect
end

def time_block(msg, &block)
    beginning_time = Time.now
    block.call
    end_time = Time.now
    puts "#{msg} : #{(end_time - beginning_time)*1000} milliseconds"
  end

class MyApp < Sinatra::Base
  enable :sessions
  enable :logging
  set :session_secret, "secret key"

  set :auth do |bool|
    condition do
      redirect '/login' unless logged_in?
    end
  end

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
    include PartialsHelper
  end

  get '/' do
    erb :home
  end
end
