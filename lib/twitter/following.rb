require "#{File.dirname(__FILE__)}/twitter_user"

class Following
  def initialize(timeline)
    @users_hash = {}
    timeline.each do |tweet|
      record(TwitterUser.parse(tweet))
    end
  end

  def to_json
    { following: sort_users(@users_hash.values) }.to_json
  end

  def record(user)
    key = user[:twitter_id]
    if @users_hash.has_key?(key)
      existing_user = @users_hash[key]
      @users_hash[key] = merge_user(existing_user, user)
    else
      @users_hash[key] = user
    end
  end

  def merge_user(existing_user, user)
    tweet_count = existing_user[:tweets].length
    existing_user[:sentiment] = ((existing_user[:sentiment] * tweet_count) + user[:sentiment]) / (tweet_count + 1)
    existing_user[:tweets] << user[:tweets].first
    existing_user
  end

  def sort_users(users)
    users.sort do |left, right|
      right[:sentiment] <=> left[:sentiment]
    end
  end
end
