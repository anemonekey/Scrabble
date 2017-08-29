require_relative 'scoring.rb'

module Scrabble

  class Player

    attr_reader :name, :plays, :total_score

    def initialize(name)
      @name = name
      @plays = []
      @total_score = 0
    end

    def play(word)
      if won?
        return false
      end

      score = Scoring.score(word)
      @total_score += score

      if score > 0
        @plays << word
      end
      
      return score
    end #end of play(word)

    def won?
      if @total_score >= 100
        return true
      end
      return false
    end #end of won?

    def highest_scoring_word
      return Scoring.highest_score(@plays)
    end #end of highest_scoring_word

    def highest_word_score
      return Scoring.score(Scoring.highest_score(@plays))
    end #end of highest_word_score

  end #end of class Player

end #end of module Scrabble
