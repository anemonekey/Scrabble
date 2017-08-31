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

    def play(word)
      if won?
        return false
      end

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

#
# person = Scrabble::Player.new("Ursula")
# tilebag = Scrabble::TileBag.new
# 10.times do
#   print "Tiles bofore draw: #{person.tiles} - #{person.tiles.length}"
#   person.draw_tiles(tilebag)
#   puts "Tiles after draw #{person.tiles} - #{person.tiles.length}\nTiles in bag: #{tilebag.tiles}"
#   puts "*****"
#   tiles = person.tiles.map { |letter| letter.to_s }
#   puts "*****"
#   puts "Person plays with word : #{person.tiles.join}"
#   person.play("#{person.tiles.join}")
#   puts "Tiles after 1 play, should be 0: #{person.tiles} - #{person.tiles.length}. Tiles in bag: #{tilebag.tiles_remaining}\nTiles in bag: #{tilebag.tiles}"
#   puts
# end
# person.draw_tiles(tilebag)
# person.tiles.length.must_equal 0
