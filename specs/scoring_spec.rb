require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'minitest/pride'
require_relative '../lib/scoring.rb'

describe "Scoring class" do

  describe "self.score(word) method" do
    it "Returns an Integer value" do
      Scrabble::Scoring.score("cat").must_be_kind_of Integer
    end

    it "Gives the correct score for a word" do
      Scrabble::Scoring.score("cat").must_equal (3+1+1)
    end

    it "Adds a bonus for 7-letter words" do
      Scrabble::Scoring.score("queenly").must_equal (10+1+1+1+1+1+4+50)
    end
  end

  # describe "self.highest_score(array_of_words) method" do
  #   it "Returns a String" do
  #     words = ["cat", "boat", "pigeon"]
  #     winner = Scrabble::Scoring.highest_score(words)
  #     winner.must_be_kind_of String
  #   end
  #
  #   it "Returns word with the highest score" do
  #     words = ["cat", "boat", "pigeon"]
  #     winner = Scrabble::Scoring.highest_score(words)
  #     winner.must_equal "pigeon"
  #   end
  #
  #   it "When tied, chooses word with fewest letters" do
  #     # snort, dog, rates == 5 points
  #     words = ["snort", "dog", "rates"]
  #     winner = Scrabble::Scoring.highest_score(words)
  #     winner.must_equal "dog"
  #   end
  #
  #   it "When tied, chooses 7-letter word over word with fewer letters" do
  #     # terrors = 7 points,
  #     words = ["terrors"]
  #     winner = Scrabble::Scoring.highest_score(words)
  #     winner.must_equal ""
  #   end
  #
  #   it "If many words with same score & length exist, chooses the first one" do
  #     words = []
  #     winner = Scrabble::Scoring.highest_score(words)
  #     winner.must_equal ""
  #   end
  # end

end
