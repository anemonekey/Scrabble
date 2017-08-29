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
      if word.class == String
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
      end
      return 0

    end #end of score method

    def self.highest_score(array)

      highest_score = 0
      highest_scores = []
      array.each do |word|
        if self.score(word) > highest_score
          highest_score = self.score(word)
          highest_scores = []
          highest_scores << word
        elsif self.score(word) == highest_score
          highest_scores << word
        end
      end

      if highest_scores.length == 1
        return highest_scores[0]
      end

      #checking for 7 letters
      # if highest_scores.max_by { |word| word.length } == 7
      #   seven_letters = []
      #   highest_scores.each do |word|
      #     if word.length == 7
      #       seven_letters << word
      #     end
      #   end
      #   return seven_letters[0]
      # end

      highest_scores.each do |word|
        if word.length == 7
          return word
        end
      end

      #checking for fewer letters
      return highest_scores.min_by { |word| word.length }

      # fewer_letters = []
      # highest_scores.each do |word|
      #   if word.length == low
      #     fewer_letters << word
      #   end
      # end
      # highest_scores.each do |word|
      #   if word.length == low.length
      #     return word
      #   end
      # end
      # return fewer_letters[0]

    end #end of highest_score method

  end #end of class Scoring

end #end of module Scrabble
