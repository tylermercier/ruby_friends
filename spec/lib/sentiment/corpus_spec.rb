require 'spec_helper'

describe Corpus do
  before :each do
    @corpus = Corpus.new
  end

  context '.lookup' do
    it 'should return 1 for missing tokens' do
      @corpus.lookup('test').should == 1
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

  context '.load_from_directory' do
    it 'should load all txt files in directory' do
      @corpus.load_from_directory 'spec/lib/sentiment/test_data'
      @corpus.token_count.should == 14
      @corpus.lookup('happy').should == 4
    end
  end
end
