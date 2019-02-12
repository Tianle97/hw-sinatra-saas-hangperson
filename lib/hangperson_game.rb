class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @current_status = :play
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  
  def guess(alphabet)
   
    raise ArgumentError if !alphabet || alphabet.empty? || !alphabet.match(/[A-Za-z]/)
    # alphabet chars to downcase
    alphabet.downcase!

  return false if @guesses.index(alphabet) || @wrong_guesses.index(alphabet)
  if word.index(alphabet)
      @guesses << alphabet
    else
      @wrong_guesses << alphabet
    end 
  end

  def word_with_guesses
    displayed = ''
    @word.each_char do |alphabet|
      if @guesses.index(alphabet)
        displayed << alphabet
      else
        displayed << '-'
      end
    end
    displayed
  end
  
  def check_win_or_lose
    
    return :lose if @wrong_guesses.length >= 7
    
    return :win if !word_with_guesses.index('-')  
    :play
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
