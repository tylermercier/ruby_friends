require 'spec_helper'

describe Classifier do
  before :each do
    positive_corpus = Corpus.new
    positive_corpus.add 'hello'
    positive_corpus.add 'hello'
    negative_corpus = Corpus.new
    negative_corpus.add 'hello'
    @classifier = Classifier.new positive_corpus, negative_corpus
  end

  context '.classify' do
    it "should record 'hello' as positive" do
      result = @classifier.classify('hello')
      result[:sentiment].should == 1
      result[:probability].should == 0.625
    end
  end
end
