#require_relative '../lib/scrabble'

module Scrabble
  class Scoring

    def initialize
      @scores = {
        1 => ["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"],
        2 => ["D", "G"],
        3 => ["B", "C", "M", "P"],
        4 => ["F", "H", "V", "W", "Y"],
        5 => ["K"],
        8 => ["J", "X"],
        10 => ["Q", "Z"]
      }
    end

    def self.score(word)
      count = 0
      for i in 0 ... str_1.length
        @scores.each do |key, value|
          if value.include?(str[1].upcase)
            count += @scores.key
          end
        end
      end

      if word.length == 7
        count += 50
      end

      return count

    end #end of def self.score

  end #end of class Scoring

end #end of module Scrabble
