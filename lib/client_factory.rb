class ClientFactory
  def self.build(user)
    auth = Authorization.find_by_user_id_and_provider(user.id, "twitter")
    Twitter::Client.new(
      oauth_token: auth.token,
      oauth_token_secret: auth.secret
    )
  end
end
