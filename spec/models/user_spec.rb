require 'spec_helper'

describe User do
  before do
    @user = User.new
  end

  subject { @user }

  it { should respond_to(:name) }

  describe '.create_from_twitter_auth' do
    before(:each) do
      twitter_auth = {
        "uid" => "123",
        "provider" => "twitter",
        "info" => { "name" => "John Doe" },
        "credentials" => {
          "token" => "token",
          "secret" => "secret"
        }
      }
      @user = User.create_from_twitter_auth(twitter_auth)
      @authorization = @user.authorizations.first
    end

    it { @user.name.should == "John Doe" }
    it { @authorization.uid.should == "123" }
    it { @authorization.provider.should == "twitter" }
    it { @authorization.token.should == "token" }
    it { @authorization.secret.should == "secret" }
  end
end
