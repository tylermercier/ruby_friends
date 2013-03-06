require "#{File.dirname(__FILE__)}/corpus"
require "#{File.dirname(__FILE__)}/settings"

class Calculator
  def initialize positive_corpus, negative_corpus
    @positive_corpus = positive_corpus
    @negative_corpus = negative_corpus
  end

  def classify(text)
    @total_probability = 0
    @inverse_total_probability = 0

    Parser.tokenize(text).each do |token|
      next if Settings::STOP_WORDS.include? token

      positive_count = @positive_corpus.lookup(token)
      negative_count = @negative_corpus.lookup(token)

      probability = calculate_probability(
        positive_count,
        @positive_corpus.token_count,
        negative_count,
        @negative_corpus.token_count
      )

      record_probability(probability)
    end

    final_probability = combine_probabilities()

    sentiment = compute_sentiment(final_probability)

    return { text: text, sentiment: sentiment, probability: final_probability }
  end

  def calculate_probability positive_count, positive_total, negative_count, negative_total
    total = positive_count + negative_count
    positive_ratio = positive_count / positive_total
    negative_ratio = negative_count / negative_total

    both_ratios = positive_ratio + negative_ratio
    probability = 0
    if both_ratios != 0
      probability = positive_ratio.to_f / both_ratios
    end

    default_weight = Settings::UNKNOWN_WORD_STRENGTH * Settings::UNKNOWN_WORD_PROBABILITY
    actual_weight = total * probability

    (default_weight + actual_weight) / (Settings::UNKNOWN_WORD_STRENGTH + total)
  end

  def record_probability probability
    return if probability.nan?

    @total_probability = 1 if @total_probability == 0 || @total_probability.nil?
    @inverse_total_probability = 1 if @inverse_total_probability == 0 || @inverse_total_probability.nil?

    @total_probability = @total_probability * probability
    @inverse_total_probability = @inverse_total_probability * (1 - probability)
  end

  def combine_probabilities
    return 0.5 if @total_probability == 0
    @total_probability / (@total_probability + @inverse_total_probability)
  end

  def compute_sentiment(probability)
    return 1 if probability > Settings::POSITIVE_TOLERANCE
    return -1 if probability < Settings::NEGATIVE_TOLERANCE
    0
  end
end
