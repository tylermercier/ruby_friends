class Document
  def initialize content
    @tokens = content.downcase.split.
      reject { |item| item.strip.empty? }.
      uniq
  end

  def each_word
    @tokens.each { |word| yield word }
  end
end
