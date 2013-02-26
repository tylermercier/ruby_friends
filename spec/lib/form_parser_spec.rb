require 'spec_helper'

describe FormParser do
  context '.parse' do
    before :each do
      form_string = "oauth_token=1234&oauth_token_secret=5678&user_id=0001&screen_name=tester"
      @form_data = FormParser.parse form_string
    end

    it 'should parse oauth token' do
      @form_data["oauth_token"].should == "1234"
    end

    it 'should parse oauth token secret' do
      @form_data["oauth_token_secret"].should == "5678"
    end

    it 'should parse screen name' do
      @form_data["screen_name"].should == "tester"
    end
  end
end
