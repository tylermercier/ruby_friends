require 'spec_helper'

describe Parser do
  context '.tokenize' do
    it 'should tokenize text' do
      tokens = Parser.tokenize "\"This\" is 'awesome!'"
      tokens.should == ['this', 'is', 'awesome']
    end

    it 'should remove whitespace' do
      tokens = Parser.tokenize "   This   is some   text          "
      tokens.should == ['this', 'is', 'some', 'text']
    end

    it 'should remove urls' do
      tokens = Parser.tokenize "check out this link http://www.google.com"
      tokens.should == ['check', 'out', 'this', 'link']
    end

    it 'should remove urls' do
      tokens = Parser.tokenize "check out this link bit.ly/urlwiki"
      tokens.should == ['check', 'out', 'this', 'link']
    end

    it 'should filter symbols' do
      text = "valid !\"\#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ result 01test"
      tokens = Parser.tokenize text
      tokens.should == ['valid', 'result']
    end

    it 'should ignore words mixed with symbols' do
      text = "#hashTag @mention Only"
      tokens = Parser.tokenize text
      tokens.should == ['only']
    end

    it 'should remove duplicates' do
      tokens = Parser.tokenize "one one two two"
      tokens.should == ['one', 'two']
    end
  end
end
