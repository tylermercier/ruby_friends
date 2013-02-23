require File.dirname(__FILE__) + "/spec_helper"

describe "App" do
  def app
    @app ||= MyApp
  end

  context "basic http" do
    it "should respond to root and not require http_authentication" do
      get "/"
      last_response.should be_ok
    end
  end
end
