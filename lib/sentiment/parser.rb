class Parser
  def self.tokenize(text)
    Tokenizer.new(text)
      .remove_punctuation
      .remove_words_attached_to_symbols
      .split_into_tokens
  end
end

class Tokenizer
  def initialize(text)
    @text = text.downcase.strip
  end

  def remove_punctuation
    @text = @text.gsub(/[!,.'"]/, '')
    self
  end

  def remove_words_attached_to_symbols
    @text = @text.gsub(/\w*([^\w\s]|\d)+\w*/, '')
    self
  end

  def split_into_tokens
    tokens = @text.split(/\W+/)
    tokens.delete_if(&:empty?).uniq
  end
end
