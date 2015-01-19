module RBHangman
  class Word < DB
    attr_reader :revealed, :wrong, :used

    class << self
      def in_database?(word)
        DB.new.has_record?('DICTIONARY', word, 'WORD')
      end

      def add_new(word)
        if(in_database?(word) or word == "")
          raise ArgumentError, "Incorrect input entered!"
        else
          DB.new.inserter('DICTIONARY', "'#{word.upcase}'", 'WORD')
        end
      end
    end

    def try(letter)
      state
      @used << letter.upcase unless @used.include?(letter.upcase)
      has_letter?(letter) ? reveal(letter) : @wrong = @wrong + 1
      state
      @revealed
    end

    private

    def initialize
      @hidden = selector('word',
                         'dictionary',
                         nil,
                         "RANDOM() LIMIT 1")[0][0].upcase.chars
                         #letter encryption????
      @revealed = @hidden.map { |letter| letter = "_" }
      @wrong = 0
      @used = []
    end

    def state
      throw :success if @wrong < 10 and @hidden.join("") == @revealed.join("")
      throw :failure if @wrong >= 10
    end

    def reveal(letter)
      @hidden.each.with_index do |secret_letter, index|
        if(letter.upcase == secret_letter.upcase)
          @revealed[index] = letter.upcase
        end
      end
      @revealed
    end

    def has_letter?(letter)
      @hidden & [letter.upcase] == [letter.upcase]
    end
  end
end
