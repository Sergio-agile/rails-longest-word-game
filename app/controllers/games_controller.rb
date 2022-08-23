require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(8)
  end

  def score
    @word = params[:word].downcase
    @letters = params[:letters].gsub(" ", "").downcase
    pattern = "[#{@letters}]"
    result = @word.match?(/#{pattern}/)
    valid = false
    if result.nil?
      @score = "the word #{@word} can't be built from #{@word}"
      valid = false
    else
      @score = "the word #{@word} is valid"
    end

    @score += ". Word #{@word} does not exists actually" if check_word_exists && valid == false

    debugger
  end

  private

  def check_word_exists
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    response = URI.open(url).read
    info = JSON.parse(response)
    return info["found"]
  end


end
