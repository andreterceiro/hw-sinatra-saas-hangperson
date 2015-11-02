class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  attr_accessor :word, :guesses, :wrong_guesses 

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = '' 
    @wrong_guesses = ''
  end

  def guess(letter)
    raise ArgumentError.new if not (letter.instance_of? String)
    letter.downcase!
    raise ArgumentError.new if not (letter.match("^[a-z]$"))

    return false if guessed_previously? letter

    if word.include? letter
      @guesses = @guesses + letter
    else 
      @wrong_guesses = @wrong_guesses + letter
    end

    true
  end

  def word_with_guesses
    word_masked =''
    @word.each_char do |char| 
      if @guesses.include? char
        word_masked = word_masked + char
      else 
        word_masked = word_masked + '-'
      end
    end

    word_masked
  end

  def guessed_previously? letter
    (@guesses.include? letter) or (@wrong_guesses.include? letter)
  end

  def check_win_or_lose
    
    if @word.empty?
      :none
    elsif @word.eql? word_with_guesses
      :win
    elsif @wrong_guesses.length > 6
      :lose
    else 
      :play
    end
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
end
