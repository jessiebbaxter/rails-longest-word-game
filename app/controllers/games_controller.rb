require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
  	@letters = (0...10).map { ('a'..'z').to_a[rand(26)].upcase }
  end

  def score
  	@word = params[:word]
  	@grid = params[:letters]
    
    grid_valid = grid_validator()
  	dict_valid = dict_validator()

  	if dict_valid == false
  		@result = "Sorry but #{@word.upcase} is not a valid english word"
  	elsif grid_valid == false
  		@result = "Sorry but #{@word.upcase} can not be generated from #{params[:letters].chars.join(", ")}"
  	else
  		if session[:score].nil?
  			@result = "Congratulations! You scored #{@word.length ** 2} with your word #{@word.upcase}" 
  			session[:score] = @word.length ** 2
  		else 
  			session[:score] += @word.length ** 2
  			@result = "Congratulations! You scored #{@word.length ** 2} with your word #{@word.upcase}. Your total score is #{session[:score]}." 
  		end
  	end
  end

  def dict_validator
  	user = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{params[:word]}").read)
  	return user["found"]
  end

  def grid_validator
  	grid_h = Hash.new(0)
  	word_h = Hash.new(0)
  	@word.downcase.split("").map { |char| word_h[char] += 1 }
  	@grid.downcase.split("").map { |char| grid_h[char.downcase] += 1 }

  	return @word.downcase.split("").all? { |char| word_h[char[0]] <= grid_h[char[0]] }
  end
end