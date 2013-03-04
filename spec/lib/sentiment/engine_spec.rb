require 'spec_helper'

describe Engine do
  context '.parse' do
    before :each do
      @engine = Engine.new
    end

    it 'should parse oauth token' do
      false.should == false
    end
  end
end
