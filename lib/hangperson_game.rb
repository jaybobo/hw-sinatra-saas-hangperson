class HangpersonGame
  attr_reader :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def letter?(letter)
    letter =~ /[A-Za-z]/
  end

  def guess(letter)
    raise ArgumentError if !letter?(letter)
    letter.downcase!
    repeat = @guesses.include?(letter)|| @wrong_guesses.include?(letter)
    if !repeat
      valid = @word.include? letter
      @guesses << letter if valid
      @wrong_guesses << letter unless valid
      true
    else 
      false
    end
  end

  def word_with_guesses
    show_word = @word.chars.collect{ |char| @guesses.include?(char) ? char : '-'}.join('')
  end

  def check_win_or_lose
    return :win if @guesses.length == @word.length
    return :lose if @wrong_guesses.length == 7
    :play
  end



end
