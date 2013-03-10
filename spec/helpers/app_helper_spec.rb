require 'spec_helper'

describe AppHelper do
  before :each do
    @helper = Class.new do
      include AppHelper
    end.new
  end

  context '#logged_in?' do
    it 'should return true when user exists' do
      @helper.instance_variable_set(:@current_user, true)
      @helper.logged_in?.should be_true
    end

    it 'should return false when user does not exist' do
      @helper.instance_variable_set(:@current_user, nil)
      @helper.logged_in?.should be_false
    end
  end

  context '#pretty_date' do
    it 'should display date' do
      time = Time.parse("2013-02-23 13:30:00 UTC")
      result = @helper.pretty_date(time)
      result.should == "23 Feb 2013"
    end
  end

  context '#pretty_time' do
    it 'should display time' do
      time = Time.parse("2013-02-23 13:30:00 UTC")
      result = @helper.pretty_time(time)
      result.should == "01:30PM"
    end
  end
end
