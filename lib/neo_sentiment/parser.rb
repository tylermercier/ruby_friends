class Parser
  def self.tokenize(text)
    Tokens.new(text)
      .clean_text
      .remove_punctuation
      .remove_words_attached_to_symbols
      .tokenize
      .clean_tokens
      .tokens
  end
end

class Tokens
  def initialize(text)
    @text = text
  end

  def clean_text
    @text = @text.downcase.strip
    self
  end

  def remove_punctuation
    @text = @text.gsub(/[!,.'"]/, '')
    self
  end

  def remove_words_attached_to_symbols
    @text = @text.gsub(/\w*([^\w\s]|\d)+\w*/, '')
    self
  end

  def tokenize
    @tokens = @text.split(/\W+/)
    self
  end

  def clean_tokens
    @tokens = @tokens.delete_if(&:empty?).uniq
    self
  end

  def tokens
    @tokens
  end
end
