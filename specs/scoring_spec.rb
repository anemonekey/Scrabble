require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'minitest/pride'
require_relative '../lib/scrabble'

describe "Scoring class" do
  describe "self.score(word) method" do
    it "Gives a score for the word" do
      cat = Scrabble::Scoring.score("cat")
      cat.must_equal 5
    end
  end
  describe "self.highest_score method" do
    it "" do
    end
  end
end
