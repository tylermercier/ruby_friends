require File.dirname(__FILE__) + "/spec_helper"

describe "App" do
  def app
    @app ||= Sinatra::Application
  end

  context "basic http" do
    it "should respond to root and not require http_authentication" do
      get "/about"
      last_response.should be_ok
    end

    it "should respond to root and not require http_authentication" do
      get "/posts"
      last_response.should be_ok
    end

    it "should respond to root and not require http_authentication" do
      get "/posts/new"
      last_response.should be_ok
    end
  end
end
