require 'spec_helper'

describe 'Helpers' do
  before :each do
    @helper = Class.new do
      include PartialsHelper
    end.new
  end

  context '#pretty_date' do
    it 'should display simple dates' do
      time = Time.parse("2013-02-23 13:30:00 UTC")
      result = @helper.pretty_date(time)
      result.should == "23 Feb 2013"
    end
  end

  context '#pretty_time' do
    it 'should display simple dates' do
      time = Time.parse("2013-02-23 13:30:00 UTC")
      result = @helper.pretty_time(time)
      result.should == "01:30PM"
    end
  end
end
