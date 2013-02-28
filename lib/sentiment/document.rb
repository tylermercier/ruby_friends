class Document
  def initialize content
    filtered = content.sub(/[^0-9a-zA-Z ]/, '').downcase.strip
    # todo filter urls
    # valid_simple_url = /^(https?:\/\/)/
    @tokens = filtered.split.reject { |item| item.strip.empty? }.uniq
  end

  def each_word
    @tokens.each { |word| yield word }
  end
end
