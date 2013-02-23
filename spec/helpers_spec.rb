require File.dirname(__FILE__) + "/spec_helper"

describe 'Helpers' do

  def app
    @app ||= Sinatra::Application
  end

  context '#title' do
    it 'should' do
      @app.title.should == 'title'
    end
  end
end
