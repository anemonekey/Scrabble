require_relative 'spec_helper'

describe "Player class" do

  before do
    @person = Scrabble::Player.new("Ursula")
    @tilebag = Scrabble::TileBag.new
  end

  describe "@name instance variable" do
    it "Returns the value of @name" do
      @person.name.must_equal "Ursula"
    end
  end

  describe "@plays Array" do
    it "Returns an Array of words played" do
      @person.plays.must_be_kind_of Array
    end
  end

  describe "play(word) method" do
    it "Does not add empty words to plays Array" do
      @person.play("")
      @person.plays.must_be_empty
    end

    it "Adds words played to plays Array" do
      first_hand = @person.draw_tiles(@tilebag)
      first_word = first_hand.sample(rand(1..7))
      second_hand = @person.draw_tiles(@tilebag)
      second_word = second_hand.sample(rand(1..7))
      @person.plays.must_equal [first_word, second_word]
    end

    it "Returns 0 when given an Integer" do
      @person.play(33).must_equal 0
    end
  end

  describe "total_score variable" do
    it "Returns the sum of scored words" do
      first_hand = @person.draw_tiles(@tilebag)
      first_word = first_hand.sample(rand(1..7))
      second_hand = @person.draw_tiles(@tilebag)
      second_word = second_hand.sample(rand(1..7))
      @person.total_score.must_equal (first_word.score + second_word.score)
    end

    it "Returns the sum of words and unexpected inputs" do
      first_hand = @person.draw_tiles(@tilebag)
      first_word = first_hand.sample(rand(1..7))
      @person.play("")
      @person.play(first_word)
      @person.play(555)
      @person.total_score.must_equal first_word.score
    end
  end

  describe "won? method" do
    it "Recognizes when someone wins the Scrabble game" do
      first_hand = @person.draw_tiles(@tilebag)
      @person.play(first_hand)
      second_hand = @person.draw_tiles(@tilebag)
      @person.play(second_hand)
      third_hand = @person.draw_tiles(@tilebag)
      @person.play(third_hand)
      @person.won?.must_equal true
    end

    it "Recognizes when someone has not won the Scrabble game" do
      first_hand = @person.draw_tiles(@tilebag)
      @person.play(first_hand.sample(rand(1..7)))
      @person.won?.must_equal false
    end
  end

  describe "highest_scoring_word method" do
    it "Gives the word with the highest score" do
      first_hand = @person.draw_tiles(@tilebag)
      first_word = @person.play(first_hand)
      second_hand = @person.draw_tiles(@tilebag)
      @person.play(second_hand.sample(3))
      third_hand = @person.draw_tiles(@tilebag)
      @person.play(third_hand.sample(4))
      @person.highest_scoring_word.must_equal first_word
    end
  end

  describe "highest_word_score method" do
    it "Gives the highest score received for a word" do
      first_hand = @person.draw_tiles(@tilebag)
      first_word = @person.play(first_hand)
      second_hand = @person.draw_tiles(@tilebag)
      @person.play(second_hand.sample(3))
      third_hand = @person.draw_tiles(@tilebag)
      @person.play(third_hand.sample(4))
      @person.highest_word_score.must_equal first_word.score
    end
  end

  describe "tiles variable" do
    it "Is an Array" do
      @person.tiles.must_be_kind_of Array
    end

    it "Does not have more than 7 tiles" do
      @person.tiles.length.must_be :<=, 7
    end
  end

  describe "draw_tiles(tilebag) method" do
    it "Fills empty tiles Array with 7 letters" do
      @person.draw_tiles(@tilebag)
      @person.tiles.length.must_equal 7
    end

    it "Fills tiles Array after playing a word with 7 letters" do
      @person.draw_tiles(@tilebag)
      @person.play("#{@person.tiles[0]}#{@person.tiles[1]}")
      @person.draw_tiles(@tilebag)
      @person.tiles.length.must_equal 7
    end

    it "Does not give tiles when hand is full" do
      first_hand = @person.draw_tiles(@tilebag)
      second_hand = @person.draw_tiles(@tilebag)
      first_hand.must_equal second_hand
    end
  end

# Optional Enhancements tests
  describe "valid? method" do
    it "Will return false when player plays letters not in their hand" do
      alphabet = @tilebag.keys.map { |letter| letter.to_s }
      user_hand = @person.draw_tiles(@tilebag)
      not_hand = []
      rand(1..7).times do
        letter = alphabet.sample(1)
        not_hand << letter unless user_hand.include? letter
      end
      @person.play(not_hand).must_equal false
    end

    it "Will return true when player plays letters in their hand" do
      user_hand = @person.draw_tiles(@tilebag)
      yes_hand = user_hand.sample(rand(1..7))
      @person.play(yes_hand).must_equal true
    end
  end
end
