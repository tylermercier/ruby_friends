require "#{File.dirname(__FILE__)}/corpus"
require "#{File.dirname(__FILE__)}/classifier"

class Analyser
  def initialize
    @positive = Corpus.new
    @negative = Corpus.new
  end

  def train_positive path
    @positive.load_from_directory path
  end

  def train_negative path
    @negative.load_from_directory path
  end

  def analyse sentence
    Classifier.new(@positive, @negative).classify(sentence)
  end
end
