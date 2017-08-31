require_relative 'scoring'

module Scrabble
  class TileBag

    attr_reader :tiles

    def initialize
      @tiles = {:A => 9, :B => 2, :C => 2, :D => 4, :E => 12, :F => 2, :G => 3, :H => 2, :I => 9, :J => 1, :K => 1, :L => 4, :M => 2, :N => 6, :O => 8, :P => 2, :Q => 1, :R => 6, :S => 4, :T => 6, :U => 4, :V => 2, :W => 2, :X => 1, :Y => 2, :Z => 1}
    end #end of initialize

    def draw_tiles(num)
      available_tiles = @tiles.select { |key, value| value != 0 }

      if tiles_remaining > 0
        drawn_tiles = available_tiles.keys.sample(num)
        @tiles.each do |key, value|
          if drawn_tiles.include?(key.to_sym)
            @tiles[key] = value - 1
          end
        end
        return drawn_tiles
      end
      return "No tiles left"

    end #end of draw method

    def tiles_remaining
      return @tiles.values.reduce(:+)
    end #end of tiles_remaining



  end #end of class


end #end of module Scrabble
