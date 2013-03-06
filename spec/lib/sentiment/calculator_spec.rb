require 'spec_helper'

describe Calculator do
  before :each do
    positive_corpus = CorpusEx.new
    positive_corpus.add 'hello'
    positive_corpus.add 'hello'
    negative_corpus = CorpusEx.new
    negative_corpus.add 'hello'
    @calculator = Calculator.new positive_corpus, negative_corpus
  end

  context '.classify' do
    it "should record 'hello' as positive" do
      result = @calculator.classify('hello')
      result[:sentiment].should == 1
      result[:probability].should == 0.625
    end
  end
end
