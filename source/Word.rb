module RBHangman
  class Word < DB
    attr_reader :revealed, :wrong, :used

    def [](letter)
      @used << letter.upcase
      has_letter?(letter) ? reveal(letter) : @wrong = @wrong + 1
      @revealed
    end

#    alias [] try

    def guessed?
      @wrong < 10 and @hidden.join("") == @revealed.join("")
    end

    def failed?
      @wrong >= 10
    end

    private

    def has_letter?(letter)
      @hidden & [letter.upcase] == [letter.upcase]
    end

    def initialize
      @hidden = selector('word',
                         'dictionary',
                         nil,
                         "RANDOM() LIMIT 1")[0][0].upcase.chars
      @revealed = @hidden.map { |letter| letter = "_" }
      @wrong = 0
      @used = []
    end

    def reveal(letter)
      @hidden.each.with_index do |secret_letter, index|
        if(letter.upcase == secret_letter.upcase)
          @revealed[index] = letter.upcase
        end
      end
      @revealed
    end
  end
end
