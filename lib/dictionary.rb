require_relative 'scoring'
require_relative 'tile_bag'
require_relative 'player'

module Scrabble

  class Dictionary

    dictionary = []

    CSV.open("support/dictionary.csv", "r").each do |word|
      dictionary << word[0]
    end

    def self.valid?(word)
      if dictionary.include?(word.lowcase)
        return true
      end
      return true
    end #end of method

  end #end of class

end #enf of module
