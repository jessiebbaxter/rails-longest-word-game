require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit games_url
  #
  #   assert_selector "h1", text: "Game"
  # end
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector ".letter-card", count: 10
  end

  test "Fill out form with random word, click play and get a response that it doesn't match the grid" do
  	visit new_url
  	fill_in "word", with: "Test" 
  	click_on "Play"
  	assert_text "Sorry but TEST can not be generated"
	end

	test "Fill out form with random letter, click play and get a response that it is not a valid english word" do
		visit new_url
  	fill_in "word", with: "W" 
  	click_on "Play"
  	assert_text "Sorry but W is not a valid english word"
	end
end