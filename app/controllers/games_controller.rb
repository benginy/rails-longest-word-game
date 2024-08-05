require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @letters = params[:letters].split
    @word = params[:word].upcase
    @score = 0

    @message = if valid_word?(@word, @letters)
      if english_word?(@word)
        @score = @word.length # Example scoring: number of letters in the word
        @message = "Congratulations! #{@word} is a valid English word!"
      else
        @message = "Sorry, but #{@word} is not a valid English word."
      end
    else
      @message = "Sorry, but #{@word} can't be built out of #{@letters.join(', ')}."
    end
  end

  private

  def valid_word?(word, letters)
    word.chars.all? { |char| word.count(char) <= letters.count(char) }
  end

  def english_word?(word)
    response = URI.open("https://dictionary.lewagon.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  rescue StandardError
    false
  end

end
