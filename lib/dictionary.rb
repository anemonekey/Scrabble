require_relative 'scoring'
require_relative 'tile_bag'
require_relative 'player'

module Scrabble

  class Dictionary

    def initialize
      @words = []

      CSV.open("support/dictionary.csv", "r").each do |word|
        @words << word[0]
      end
    end #end of initialize

    def valid?(word)
      return @words.include?(word.lowcase)
    end #end of method

  end #end of class

end #enf of module
