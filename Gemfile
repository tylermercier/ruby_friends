source 'https://rubygems.org'

gem "rake"
gem "thin"
gem "sinatra"

gem "activerecord"
gem "sinatra-activerecord"
gem "sinatra-reloader"
gem "omniauth"
gem "omniauth-oauth2"
gem "omniauth-twitter"
gem "twitter"

# blowing up in production
gem "pry"
gem "rspec"
gem "rspec-core"

group :development do
  gem "shotgun"
end

group :development, :test do
  gem "sqlite3"
  gem "rack-test"
  gem "simplecov", ">=0.4.2"
end

group :production do
  gem "pg"
end
