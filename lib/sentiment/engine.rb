require "#{File.dirname(__FILE__)}/classifier"

class Engine
  def self.load_classifier
    positive = Corpus.new
    negative = Corpus.new
    data_folder = File.join(Dir.pwd, 'lib', 'data')
    positive.load_from_directory(File.join(data_folder, 'positive'))
    negative.load_from_directory(File.join(data_folder, 'negative'))
    Classifier.new(positive, negative)
  end

  def self.analyze(sentence)
    @classifier ||= load_classifier
    @classifier.classify(sentence)
  end
end
