require "#{File.dirname(__FILE__)}/twitter_user"

class Following
  def self.parse(timeline)
    users_hash = {}

    timeline.each do |item|
      user = TwitterUser.parse(item)
      if users_hash.has_key? user[:twitter_id]
        # get the user
        existing_user = users_hash[user[:twitter_id]]
        # update user sentiment
        existing_user[:sentiment] = existing_user[:sentiment] + user[:sentiment]
        # add tweet
        existing_user[:tweets] << user[:tweets].first
      else
        users_hash[user[:twitter_id]] = user
      end
    end

    sorted_users = users_hash.values.sort do |left, right|
      right[:sentiment] <=> left[:sentiment]
    end

    { following: sorted_users }
  end
end
