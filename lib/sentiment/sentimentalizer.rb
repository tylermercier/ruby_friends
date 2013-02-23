require 'json'
require "#{File.dirname(__FILE__)}/analyser"

class Sentimentalizer
  def self.load
    analyser = Analyser.new
    data_folder = File.join(Dir.pwd, 'lib', 'data')
    analyser.train_positive File.join(data_folder, 'positive')
    analyser.train_negative File.join(data_folder, 'negative')
    analyser
  end

  def self.analyze(sentence)
    @analyser ||= load
    @analyser.analyse(sentence)
  end
end
