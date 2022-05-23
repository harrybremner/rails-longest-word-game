class GamesController < ApplicationController

  def new
    # TODO: generate random grid of letters
    charset = Array('A'..'Z')
    @letters = Array.new(10) { charset.sample }
  end

  def letters_in_grid?(word, letters)
    array = word.upcase.chars
    letters.each do |letter|
      array.delete_at(array.index(letter)) if array.include?(letter)
    end
    array[0].nil?
  end

  def score
    @word = params[:countdown]
      # TODO: runs the game and return detailed hash of result (with `:score`, `:message` and `:time` keys)
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    attempt_serialized = URI.open(url).read
    result = JSON.parse(attempt_serialized)
    @hash = {}
        # here we need to check each character in attempt against each character in grid to make sure it appears there, taking that letter off the grid each time to make sure that duplicate letters in the attempt don't pass as true ie attempt = bib, grid = bielfssd could be true if we check each 'b' in attempt against the same 'b' in grid
        @word = params[:countdown]
        @letters_new = params[:letters]
    if result["found"] && letters_in_grid?(@word, @letters_new.split())
      # hash[:time] = (end_time - start_time)
      @hash[:score] = (@word.size * @word.size)
      @hash[:message] = "Well done!"
      @test = "correct word"
    else
      # hash[:time] = (end_time - start_time)
      @hash[:score] = 0
      @hash[:message] = "That's not a word, silly!"
      @test = "incorrect word"
    end
    return @hash
  end


end
