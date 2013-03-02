require "#{File.dirname(__FILE__)}/user_form_parser"

class User < ActiveRecord::Base
  extend UserFormParser

  has_many :authorizations
  validates :name, :presence => true

  def self.create_from_twitter_auth(auth_hash)
    user = User.new name: auth_hash["info"]["name"]
    user.authorizations.build(
      provider: auth_hash["provider"],
      uid: auth_hash["uid"],
      token: auth_hash["credentials"]["token"],
      secret: auth_hash["credentials"]["secret"]
    )
    user.save
    user
  end
end
