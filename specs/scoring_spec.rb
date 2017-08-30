require_relative 'spec_helper'

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
    it "Gives the correct score for an integer" do
      Scrabble::Scoring.score(77).must_equal 0
    end
    it "Gives the correct score for a nil" do
      Scrabble::Scoring.score("").must_equal 0
    end

  end

  describe "self.highest_score(array_of_words) method" do
    it "Returns a String" do
      words = ["cat", "boat", "pigeon"]
      Scrabble::Scoring.highest_score(words).must_be_kind_of String
    end

    it "Returns word with the highest score" do
      words = ["cat", "boat", "pigeon"]
      Scrabble::Scoring.highest_score(words).must_equal "pigeon"
    end

    it "If tied, chooses word with fewest letters" do
      # snort, dog, rates, need = 5 points
      words = ["snort", "need", "dog", "rates"]
      Scrabble::Scoring.highest_score(words).must_equal "dog"
    end

    it "If tied, chooses 7-letter word over word with fewer letters" do
      # life, terrors, brain, cob = 7 points
      words = ["cob", "life", "terrors", "brain"]
      Scrabble::Scoring.highest_score(words).must_equal "terrors"
    end

    it "If many words with same score & length, chooses the first" do
      # heal, hail, vest, hair = 7 points
      words = ["heal", "hail", "vest", "hair"]
      Scrabble::Scoring.highest_score(words).must_equal "heal"
    end

    it "If multiple 7 letter words, chooses the first" do
      # artists, runless, terrors = 7 points
      words = ["artists", "runless", "terrors"]
      Scrabble::Scoring.highest_score(words).must_equal "artists"
    end

    it "If empty array, the Array given will be empty" do
      words = []
      Scrabble::Scoring.highest_score(words).must_be_nil
    end

  end

end
