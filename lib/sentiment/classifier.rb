require "#{File.dirname(__FILE__)}/document"
require "#{File.dirname(__FILE__)}/classification_result"

class Classifier

  UNKNOWN_WORD_STRENGTH = 1.0
  UNKNOWN_WORD_PROBABILITY = 0.5
  TOLERANCE = 0.05

  STOP_WORDS = %w{
      a,able,about,across,after,all,almost,also,am,among,an,and,
      any,are,as,at,be,because,been,but,by,can,cannot,could,dear,
      did,do,does,either,else,ever,every,for,from,get,got,had,has,
      have,he,her,hers,him,his,how,however,i,if,in,into,is,it,its,
      just,least,let,like,likely,may,me,might,most,must,my,neither,
      no,nor,not,of,off,often,on,only,or,other,our,own,rather,
      really,said,say,says,she,should,since,so,some,than,that,the,
      their,them,then,there,these,they,this,tis,to,too,totally,twas,
      us,wants,was,we,were,what,when,where,which,while,who,whom,why,
      will,with,would,yet,you,your
  }

  def initialize positive_corpus, negative_corpus
    @positive_corpus = positive_corpus
    @negative_corpus = negative_corpus
    @totalProbability = 0;
    @inverseTotalProbability = 0;
  end

  def classify(text)
    p "Analyzing phrase: #{text}"
    Document.new(text).each_word do |word|
      next if STOP_WORDS.include? word

      p "Analyzing word: #{word}"

      positive_matches = @positive_corpus.token_count(word)
      p "Postive Count: #{positive_matches}"
      p "Postive Total: #{@positive_corpus.entry_count}"
      negative_matches = @negative_corpus.token_count(word)
      p "Negative Count: #{negative_matches}"
      p "Negative Total: #{@negative_corpus.entry_count}"

      probability = calculate_probability(
        positive_matches,
        @positive_corpus.entry_count,
        negative_matches,
        @negative_corpus.entry_count
      )
      p "Probability: #{probability}"
      record_probability(probability)
    end

    p "Total Probability: #{@total_probability}"
    p "Inverse Total Probability: #{@inverse_total_probability}"

    final_probability = combine_probabilities()
    p "final_probability: #{final_probability}"

    sentiment = compute_sentiment(final_probability)
    p "sentiment: #{sentiment}"

    return { text: text, sentiment: sentiment, probability: final_probability }
  end

  def calculate_probability positive_count, positive_total, negative_count, negative_total
    total = positive_count + negative_count
    positive_ratio = positive_count.to_f / positive_total.to_f
    p "positive_ratio: #{positive_ratio}"
    negative_ratio = negative_count.to_f / negative_total.to_f
    p "negative_ratio: #{negative_ratio}"

    probability = positive_ratio.to_f / (positive_ratio + negative_ratio)

    ((UNKNOWN_WORD_STRENGTH * UNKNOWN_WORD_PROBABILITY) + (total * probability)) / (UNKNOWN_WORD_STRENGTH + total)
  end

  def record_probability probability
    return if probability.nan?

    @total_probability = 1 if @total_probability == 0 || @total_probability.nil?
    @inverse_total_probability = 1 if @inverse_total_probability == 0 || @inverse_total_probability.nil?

    @total_probability = @total_probability * probability
    @inverse_total_probability = @inverse_total_probability * (1-probability)
  end

  def combine_probabilities
    return 0.5 if (@total_probability == 0)
    (@total_probability / (@total_probability + @inverse_total_probability))
  end

  def compute_sentiment(probability)
    return -1 if (probability <= (0.5 - TOLERANCE))
    return 1 if (probability >= (0.5 + TOLERANCE))
    0
  end
end
