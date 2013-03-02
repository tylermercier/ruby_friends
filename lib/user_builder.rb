class UserBuilder
  def self.build(auth_string)
    auth = FormParser.parse auth_string
    Authorization.authorize({
      "provider" => "twitter",
      "uid" => auth["user_id"],
      "info" => { "name" => auth["screen_name"] },
      "credentials" => {
        "token" => auth["oauth_token"],
        "secret" => auth["oauth_token_secret"]
      }
    })
  end
end
