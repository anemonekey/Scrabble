require_relative 'scoring'
require_relative 'tile_bag'

module Scrabble

  class Player

    attr_reader :name, :plays, :total_score, :tiles

    def initialize(name)
      @name = name
      @plays = []
      @total_score = 0
      @tiles = []
    end

    def string?(word)
      return word.class == String
    end #end of string?

    def valid?(word)
      count = 0
      length = 0
      for i in 0 ... word.length
        if @tiles.include?(word[i].upcase.to_sym)
          count += 1
          length += 1
        end
      end
      return length == word.length
    end #end of valid?


    def play(word)
      if won?
        return false
      end

      if  string?(word) && valid?(word)

        score = Scoring.score(word)
        @total_score += score

        index = 0
        while index < @tiles.length
          if word.upcase.include?(@tiles[index].to_s)
            @tiles.delete(@tiles[index])
          else
            index += 1
          end
        end

        if score > 0
          @plays << word
        end

        return score
      end
      return false
    end #end of play(word)

    def won?
      return @total_score >= 100
    end #end of won?

    def highest_scoring_word
      return Scoring.highest_score(@plays)
    end #end of highest_scoring_word

    def highest_word_score
      return Scoring.score(Scoring.highest_score(@plays))
    end #end of highest_word_score



    def draw_tiles(tile_bag)
      if won?
        return false
      end

      if tile_bag.tiles_remaining > 0
        if tile_bag.tiles_remaining >= (7 - @tiles.length)
          new_tiles = tile_bag.draw_tiles(7 - @tiles.length)
        else
          new_tiles = tile_bag.draw_tiles(tile_bag.tiles_remaining)
        end
        new_tiles.each  { |tile| @tiles << tile }
        return @tiles
      end
      return false
    end #end of draw_tiles

  end #end of class Player

end #end of module Scrabble
