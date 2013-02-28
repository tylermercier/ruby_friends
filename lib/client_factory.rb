class ClientFactory
  def self.build_for_user(user)
    auth = Authorization.find_by_user_id_and_provider(user.id, "twitter")
    Twitter::Client.new(
      oauth_token: auth.token,
      oauth_token_secret: auth.secret
    )
  end

  def self.build_from_auth_string(form)
    auth = FormParser.parse params[:authString]
    user = Authorization.authorize({
      "provider" => "twitter",
      "uid" => auth["user_id"],
      "info" => { "name" => auth["screen_name"] },
      "credentials" => {
        "token" => auth["oauth_token"],
        "secret" => auth["oauth_token_secret"]
      }
    })
    build_for_user(user)
  end
end
