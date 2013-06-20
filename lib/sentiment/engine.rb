require "benchmark"
require "#{File.dirname(__FILE__)}/classifier"

class Engine
  def self.load_classifier
    classifier = nil
    time = Benchmark.measure do
      positive = Corpus.new
      negative = Corpus.new
      data_folder = File.join(Dir.pwd, 'lib', 'data')
      positive.load_from_directory(File.join(data_folder, 'positive'))
      negative.load_from_directory(File.join(data_folder, 'negative'))
      classifier = Classifier.new(positive, negative)
    end
    puts "Load Corpus: #{time}"
    classifier
  end

  def self.analyze(sentence)
    @classifier ||= load_classifier
    @classifier.classify(sentence)
  end
end
