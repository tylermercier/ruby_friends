require "#{File.dirname(__FILE__)}/parser"
require "#{File.dirname(__FILE__)}/settings"

class Corpus
  attr_reader :token_count

  def initialize
    @tokens = {}
    @token_count = 0
  end

  def lookup(token)
    return @tokens[token] if @tokens[token].present?
    Settings::UNKNOWN_WORD_STRENGTH
  end

  def add(text)
    Parser.tokenize(text).each do |token|
      if @tokens[token].present?
        @tokens[token] = @tokens[token] + 1
      else
        @tokens[token] = 1
        @token_count = @token_count + 1
      end
    end
  end

  def load_from_directory(directory)
    Dir.glob("#{directory}/*.txt") do |entry|
      IO.foreach(entry) do |line|
        add line
      end
    end
  end
end
