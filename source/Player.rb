module RBHangman
  class GameOver < StandardError
  end

  class Player < DB
    attr_reader :word, :score
    attr_accessor :name

    def [](letter)
      raise GameOver if(@word.failed?)
       @word[letter] unless(@word.guessed?)
      if(@word.guessed? and not(@word_scored))
        @score = @score + 1
        @word_scored = true
        @word
      end

      if(@word.failed?)
        save_highscore
        @failed = true
        raise GameOver, "Game Over: score: #@score, player: #@name"
      end
      self.word.revealed
    end

    def failed?
      @failed
    end

    def new_word
      @word_scored = false
      @word = Word.new
    end

    def save_highscore
      if(has_record?('HIGHSCORES', "#{@name.upcase}", 'PLAYER'))
        old = selector('SCORE', 'HIGHSCORES', "PLAYER='#@name'")[0][0]
        updater('HIGHSCORES',
                "PLAYER='#{@name.upcase}', SCORE=#@score",
                "PLAYER='#{@name.upcase}'") if(old < @score)
      else
        inserter('HIGHSCORES', "'#{@name.upcase}', #@score", "PLAYER, SCORE")
      end
    end

    private

    def initialize
      @name = "GUEST"
      @word = Word.new
      @score = 0
      @failed = false
      @word_scored = false
    end
  end
end
