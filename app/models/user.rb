class User < ActiveRecord::Base
  has_many :authorizations
  validates :name, :presence => true

  def twitter_client
    auth = Authorization.find_by_user_id_and_provider(id, "twitter")
    Twitter::Client.new(
      oauth_token: auth.token,
      oauth_token_secret: auth.secret
    )
  end

  def self.build_from_hash(auth_hash)
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
