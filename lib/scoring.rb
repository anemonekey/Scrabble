module Scrabble
  class Scoring

    attr_reader :scores

      SCORES = {
        1 => ["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"],
        2 => ["D", "G"],
        3 => ["B", "C", "M", "P"],
        4 => ["F", "H", "V", "W", "Y"],
        5 => ["K"],
        8 => ["J", "X"],
        10 => ["Q", "Z"]
      }

    def self.score(word)
      count = 0
      for i in 0 ... word.length
        SCORES.each do |key, value|
          if value.include?(word[i].upcase)
            count += key
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
