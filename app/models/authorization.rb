require "#{File.dirname(__FILE__)}/client_builder"

class Authorization < ActiveRecord::Base
  extend ClientBuilder

  belongs_to :user
  validates :provider, :uid, :presence => true

  def update_from_twitter_auth(auth_hash)
    self.token = auth_hash["credentials"]["token"]
    self.secret = auth_hash["credentials"]["secret"]
    save
  end

  def self.authorize(auth_hash)
    #print_auth(auth_hash)
    authorization = find_by_twitter_auth(auth_hash)
    if authorization.present?
      authorization.update_from_twitter_auth(auth_hash)
      authorization.user
    else
      User.create_from_twitter_auth(auth_hash)
    end
  end

  def self.find_by_twitter_auth(auth_hash)
    find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
  end

  def self.print_auth(auth_hash)
    puts "Provider: #{auth_hash["provider"]}"
    puts "UserID: #{auth_hash["uid"]}"
    puts "Name: #{auth_hash["info"]["name"]}"
    puts "Token: #{auth_hash["credentials"]["token"]}"
    puts "Secret: #{auth_hash["credentials"]["secret"]}"
  end
end
