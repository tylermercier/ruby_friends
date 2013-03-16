require "#{File.dirname(__FILE__)}/analyzer"

class Engine
  def self.load
    analyzer = Analyzer.new
    data_folder = File.join(Dir.pwd, 'lib', 'data')
    analyzer.train_positive File.join(data_folder, 'positive')
    analyzer.train_negative File.join(data_folder, 'negative')
    analyzer
  end

  def self.analyze(sentence)
    @analyzer ||= load
    @analyzer.analyse(sentence)
  end
end
