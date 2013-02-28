require 'spec_helper'

describe Authorization do
  before do
    @authorization = Authorization.new
  end

  subject { @authorization }

  it { should respond_to(:provider) }
  it { should respond_to(:uid) }
  it { should respond_to(:token) }
  it { should respond_to(:secret) }

  describe '.update_from_twitter_auth' do
    before(:each) do
      @authorization.token = nil
      @authorization.secret = nil
      twitter_auth = {
          "credentials" => {
            "token" => "token",
            "secret" => "secret"
          }
        }
      @authorization.update_from_twitter_auth(twitter_auth)
    end

    it { @authorization.token.should == "token" }
    it { @authorization.secret.should == "secret" }
  end

  describe '#authorize' do
    it 'should use existing account when one exists' do
    end
    it 'should create account when not exists' do
    end
  end
end
