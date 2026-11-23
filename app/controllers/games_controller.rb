require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10){('A'..'Z').to_a.sample}
  end

  def score
    @word = params[:word]
    @letters = params[:letters]

    if !in_grid?(@word, @letters)
      @result = "Sorry, but #{@word.upcase} can't be built out of #{@letters.chars.join(", ")}"
    elsif !english_word?(@word)
      @result = "Sorry, but #{@word.upcase} does not seem to be a valid English word..."
    else
      @result = "Congratulations! #{@word.upcase} is a valid English word!"
    end

  end


private

  def in_grid?(word, letters)
    word.upcase.chars.each do |letter|
      return false if word.upcase.count(letter) > letters.count(letter)
    end
    true
  end

  def english_word?(word)
    url = "https://dictionary.lewagon.com/#{word}"
    response = URI.open(url).read
    json = JSON.parse(response)
    json["found"]
  end

end
