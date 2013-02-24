require "#{File.dirname(__FILE__)}/document"

class Corpus
  def initialize
    @tokens = {}
    @totalTokens = 0
  end

  def entry_count
    #@tokens.values.inject(0, :+)
    @totalTokens
  end

  def add(document)
    document.each_word do |word|
      if @tokens[word].present?
        @tokens[word] = @tokens[word] + 1
      else
        @tokens[word] = 0
      end
    end
  end

  def load_from_directory(directory)
    Dir.glob("#{directory}/*.txt") do |entry|
      IO.foreach(entry) do |line|
        add Document.new(line)
      end
    end
    @totalTokens = count_total_entries(@tokens);
  end

  def token_count(word)
    @tokens[word] || 0
  end

  def count_total_entries(tokens)
    total = 0;
    tokens.each do |word|
      if @tokens[word].present?
        total += tokens[word]
      end
    end
    total
  end
end
