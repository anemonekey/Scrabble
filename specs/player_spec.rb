require_relative 'spec_helper'

describe "Player class" do

  before do
    @person = Scrabble::Player.new("Ursula")
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
    it "Does not add empty words to Array" do
      @person.play("")
      @person.plays.must_be_empty
    end
    it "Adds word played to Array" do
      @person.play("ariel")
      @person.play("sebastian")
      @person.plays.must_equal ["ariel", "sebastian"]
    end
    it "Raises an error when given an Integer" do
      @person.play(33).must_equal 0
    end
  end

  describe "total_score variable" do
    it "Returns the sum of scored words" do
      @person.play("terrors")
      @person.play("dog")
      @person.total_score.must_equal 62
    end
    it "Returns the sum of words and unexpected inputs" do
      @person.play("")
      @person.play("dog")
      @person.play(555)

      @person.total_score.must_equal 5
    end
  end

  describe "won? method" do
    it "Recognizes when someone wins the Scrabble game" do
      @person.play("pizzazz")
      @person.play("jacuzzi")
      @person.play("quizzes")
      @person.won?.must_equal true
    end

    it "Recognizes when someone has not won the Scrabble game" do
      @person.play("cat")
      @person.won?.must_equal false
    end
  end

  describe "highest_scoring_word method" do
    it "Gives the word with the highest score" do
      @person.play("cat")
      @person.play("jacuzzi")
      @person.play("quizzes")
      @person.highest_scoring_word.must_equal "jacuzzi"
    end
  end

  describe "highest_word_score method" do
    it "Gives the highest score received for a word" do
      @person.play("cat")
      @person.play("jacuzzi")
      @person.play("quizzes")
      @person.play("")
      @person.highest_word_score.must_equal 84
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
      tilebag = Scrabble::TileBag.new
      @person.draw_tiles(tilebag)
      @person.tiles.length.must_equal 7
    end

    it "Fills tiles Array after playing a word with 7 letters" do
      tilebag = Scrabble::TileBag.new
      @person.draw_tiles(tilebag)
      @person.play("#{@person.tiles[0]}#{@person.tiles[1]}")
      @person.draw_tiles(tilebag)
      @person.tiles.length.must_equal 7
    end

    it "Does not give tiles when hand is full" do
      tilebag = Scrabble::TileBag.new
      first_hand = @person.draw_tiles(tilebag)
      second_hand = @person.draw_tiles(tilebag)
      first_hand.must_equal second_hand
    end

  end

end
