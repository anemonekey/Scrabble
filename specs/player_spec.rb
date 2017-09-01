require_relative 'spec_helper'

# TODO # For all existing tests
# class MockDictionary
#   def valid?(word)
#     return true
#   end
# end
#
# # For checking that if word doesn't exist it will fail.
# class MockDictionary2
#   def valid?(word)
#     return false
#   end
# end
#
# # a, b, c
# class MockDictionary3
#   def initialize
#     @words = ["dog", "cat", "adsf"]
#   end
#   def valid?(word)
#     return @words.include?(word)
#   end
# end

describe "Player class" do

  before do
    @person = Scrabble::Player.new("Ursula")#, MockDictionary.new())
    @tilebag = Scrabble::TileBag.new
  end

  describe "Instance variables" do
    it "Returns the value of @name" do
      @person.name.must_equal "Ursula"
    end

    it "Returns an Array of words played" do
      @person.plays.must_be_kind_of Array
    end

    it "Returns a Hash of user's tiles" do
      @person.tiles.tiles.must_be_kind_of Hash
    end
  end

  describe "#play(word) method" do
    it "Does not add empty words to plays Array" do
      @person.play("")
      @person.plays.must_be_empty
    end

    it "Adds words played to plays Array" do
      first_hand = @person.draw_tiles(@tilebag)
      first_word = first_hand.sample(rand(1..7)).join
      @person.play(first_word)
      second_hand = @person.draw_tiles(@tilebag)
      second_word = second_hand.sample(rand(1..7)).join
      @person.play(second_word)
      @person.plays.must_equal [first_word, second_word]
    end

    it "Returns false when given an Integer" do
      @person.play(33).must_equal false
    end
  end

  describe "@total_score variable" do
    it "Returns the sum of scored words" do
      first_hand = @person.draw_tiles(@tilebag)
      first_word = first_hand.sample(rand(1..7)).join
      @person.play(first_word)
      second_hand = @person.draw_tiles(@tilebag)
      second_word = second_hand.sample(rand(1..7)).join
      @person.play(second_word)
      @person.total_score.must_equal (Scrabble::Scoring.score(first_word) + Scrabble::Scoring.score(second_word))
    end

    it "Returns the sum of words and unexpected inputs" do
      first_hand = @person.draw_tiles(@tilebag)
      first_word = first_hand.sample(rand(1..7)).join
      @person.play("")
      @person.play(first_word)
      @person.play(555)
      @person.total_score.must_equal Scrabble::Scoring.score(first_word)
    end
  end

  describe "won? method" do
    it "Recognizes when someone wins the Scrabble game" do
      2.times do
        hand = @person.draw_tiles(@tilebag)
        @person.play(hand.join)
      end
      @person.won?.must_equal true
    end

    it "Recognizes when someone has not won the Scrabble game" do
      first_hand = @person.draw_tiles(@tilebag)
      @person.play(first_hand.sample(rand(1..7)).join)
      @person.won?.must_equal false
    end
  end

  describe "highest_scoring_word method" do
    it "Gives the word with the highest score" do
      first_hand = @person.draw_tiles(@tilebag)
      first_word = first_hand.join
      @person.play(first_word)
      second_hand = @person.draw_tiles(@tilebag)
      @person.play(second_hand.sample(3).join)
      third_hand = @person.draw_tiles(@tilebag)
      @person.play(third_hand.sample(4).join)
      @person.highest_scoring_word.must_equal first_word
    end
  end

  describe "highest_word_score method" do
    it "Gives the highest score received for a word" do
      first_hand = @person.draw_tiles(@tilebag)
      first_word = first_hand.join
      @person.play(first_word)
      second_hand = @person.draw_tiles(@tilebag)
      @person.play(second_hand.sample(3).join)
      third_hand = @person.draw_tiles(@tilebag)
      @person.play(third_hand.sample(4).join)
      @person.highest_word_score.must_equal Scrabble::Scoring.score(first_word)
    end
  end

  describe "tiles variable" do
    it "Is a Hash" do
      @person.tiles.must_be_kind_of Hash
    end

    it "Has 26 key-value pairs" do
      @person.tiles.length.must_equal 26
    end
  end

  describe "draw_tiles(tilebag) method" do
    it "Fills empty tiles Hash with 7 letters" do
      @person.draw_tiles(@tilebag)
      tiles = @person.tiles.map { |key, value| value.sum }
      tiles.must_equal 7
    end

    it "Fills tiles Hash after playing a word with 7 letters" do
      @person.draw_tiles(@tilebag)
      playable_tiles = @person.tiles.select { |key, value| value > 0 }
      @person.play("#{playable_tiles.keys[0]}#{playable_tiles.keys[1]}")
      @person.draw_tiles(@tilebag)
      tiles = @person.tiles.map { |key, value| value.sum }
      tiles.must_equal 7
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
      alphabet = @tilebag.tiles.keys.map { |letter| letter.to_s }
      user_hand = @person.draw_tiles(@tilebag)
      not_hand = []
      rand(1..7).times do
        letter = alphabet.sample(1)
        not_hand << letter unless user_hand.keys.to_s include? letter
      end
      @person.valid?((not_hand).join).must_equal false
    end

    it "Will return true when player plays letters in their hand" do
      user_hand = @person.draw_tiles(@tilebag)
      yes_hand = user_hand.sample(rand(1..7)).join
      @person.valid?(yes_hand).must_equal true
    end
  end
end
