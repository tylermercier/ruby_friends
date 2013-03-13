source 'https://rubygems.org'

gem "rake"
gem "sinatra"

gem "activerecord"
gem "sinatra-activerecord"
gem "sinatra-reloader"
gem "omniauth"
gem "omniauth-oauth2"
gem "omniauth-twitter"
gem "twitter"

group :development do
  gem "shotgun"
  gem "pry"
end

group :development, :test do
  gem "sqlite3"
  gem "rack-test"
  gem "rspec"
  gem "rspec-core"
  gem "simplecov", ">=0.4.2"
end

group :production do
  gem "pg"
end
