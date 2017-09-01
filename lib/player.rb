require_relative 'scoring'
require_relative 'tile_bag'

module Scrabble

  class Player

    attr_reader :name, :plays, :total_score, :tiles

    def initialize(name) #, dictionary
      @name = name
      @plays = []
      @total_score = 0
      # TODO tiles can be empty TileBag class instance
      @tiles = TileBag.new(true)
      # @dictionary = dictionary
    end

    # TODO Make class method
    # TODO Consider moving to separate Utils class
    def string?(word)
      return word.class == String
    end #end of string?

   # TODO Check for duplicate letters, separate tiles object. Add new tests.
   # TODO consider making private method
   # TODO consider moving private methods to the end of the file
   # A=1 AAAAAAA
   # TODO This method should belong to Tilebag class.




    def play(word)
      # TODO Move argument checks at first.
      #if not string?(word)
      #  return false
      #end

      if won?
        return false
      end

      puts "==============="
      puts "Valid #{valid?(word)}"
      puts "==============="


      if string?(word) && valid?(word)# && @dictionary.valid?(word)
        @plays << word

        score = Scoring.score(word)
        @total_score += score

        # TODO Extract to separate method
        # TODO This should belong to TileBag class
        # index = 0
        # while index < @tiles.tiles.values.sum
        #   if word.upcase.include?(@tiles[index].to_s)
        #     @tiles.delete(@tiles[index])
        #   else
        #     index += 1
        #   end
        # end
        @tiles.tiles.each do |key, value|
          if word.upcase.include?(key.to_s)
            @tiles.tiles[key] -= 1
          end
        end

        # if score > 0

        # end

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
      # puts "Tiles: #{@tiles}"

      if won?
        return false
      end

      # TODO It is possible to make it more compact
      if tile_bag.tiles_remaining > 0
        if tile_bag.tiles_remaining >= (7 - @tiles.tiles.values.sum)
          new_tiles = tile_bag.draw_tiles(7 - @tiles.tiles.values.sum)
        else
          new_tiles = tile_bag.draw_tiles(tile_bag.tiles_remaining)
        end
        # new_tiles.each  { |tile| @tiles << tile }
        # puts "keys: #{@tiles.tiles.keys}"
        new_tiles.each do |tile|
          # puts "checking against #{tile}"
          # puts tile.class
          @tiles.tiles[tile.upcase.to_sym] += 1
          # puts @tiles.tiles
        end
        return @tiles.tiles.keys
      end
      return false
    end #end of draw_tiles

    def valid?(word)
      count = 0
      for i in 0 ... word.length
        # available_tiles = @tiles.tiles.select { |key, value| value > 0 }
        # if available_tiles.keys.include?(word[i].upcase.to_sym)
        puts @tiles.tiles
        if @tiles.tiles[word[i].upcase.to_sym] > 0
          @tiles.tiles[word[i].upcase.to_sym] -= 1
          puts word[i], word[i].class
          # @tiles.tiles[word[i].to_sym] -= 1
          count += 1
          puts count
        end
        # end
      end
      puts count
      puts word.length
      return count == word.length
    end #end of valid?

  end #end of class Player

end #end of module Scrabble

#tests

person = Scrabble::Player.new("Ursula")
tilebag = Scrabble::TileBag.new

# puts person.name
# puts "*****"
# person.draw_tiles(tilebag)
# puts "*****"
# puts person.tiles.tiles
# if person.play("hello") == false
#   puts "passed"
# end
puts person.name

person.draw_tiles(tilebag)
playable_tiles = person.tiles.tiles.select { |key, value| value > 0 }
puts playable_tiles
first_word = playable_tiles.keys.sample(rand(1..7)).join
puts first_word

person.play(first_word)


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
