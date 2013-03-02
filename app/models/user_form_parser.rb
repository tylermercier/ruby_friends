module UserFormParser
  def parse_from_auth_string(auth_string)
    auth = FormParser.parse auth_string
    Authorization.authorize({
      "provider" => "twitter",
      "uid" => auth["user_id"],
      "info" => {
        "name" => auth["screen_name"]
      },
      "credentials" => {
        "token" => auth["oauth_token"],
        "secret" => auth["oauth_token_secret"]
      }
    })
  end
end

class FormParser
  def self.parse(form)
    keys = {}
    parts = form.split('&')
    parts.each do |part|
      temp = part.split('=')
      keys[temp[0]] = temp[1]
    end
    keys
  end
end
