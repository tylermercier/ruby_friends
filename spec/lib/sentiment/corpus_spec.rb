require 'spec_helper'

describe CorpusEx do
  before :each do
    @corpus = CorpusEx.new
  end

  context '.lookup' do
    it 'should return zero for missing tokens' do
      @corpus.lookup('test').should == 0
    end

    it 'should return count for existing tokens' do
      @corpus.add 'test test test' # multiples only count once
      @corpus.add 'test'
      @corpus.lookup('test').should == 2
    end
  end

  context '.add' do
    it 'should include new tokens' do
      @corpus.add "This is some text"
      @corpus.token_count.should == 4
    end
  end
end
