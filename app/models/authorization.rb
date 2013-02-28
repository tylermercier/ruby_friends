class Authorization < ActiveRecord::Base
  belongs_to :user
  validates :provider, :uid, :presence => true

  def update_from_hash(auth_hash)
    token = auth_hash["credentials"]["token"]
    secret = auth_hash["credentials"]["secret"]
    save
  end

  def self.authorize(auth_hash)
    authorization = find_by_hash(auth_hash)
    if authorization
      authorization.update_from_hash(auth_hash)
      authorization.user
    else
      User.create_from_twitter_auth(auth_hash)
    end
  end

  def self.find_by_hash(auth_hash)
    find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
  end
end
