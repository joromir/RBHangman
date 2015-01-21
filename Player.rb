module RBHangman
  class GameOver < StandardError
  end

  class Player < DB
    attr_reader :word, :score
    attr_accessor :name

    def initialize
      @name = 'GUEST'
      reset
    end

    def reset
      @word = Word.new
      @score = 0
      @failed = false
      @word_scored = false
      self
    end

    def new_word
      @word_scored = false
      @word = Word.new
    end

    def failed?
      @failed
    end

    def save_highscore
      old = selector('SCORE', 'HIGHSCORES', "PLAYER='#@name'")[0][0]
      if(has_record?('HIGHSCORES', "#{@name.upcase}", 'PLAYER') and old < @score)
        updater('HIGHSCORES',
                "PLAYER='#{@name.upcase}', SCORE=#@score",
                "PLAYER='#{@name.upcase}'")
      else
        inserter('HIGHSCORES', "'#{@name.upcase}', #@score", "PLAYER, SCORE")
      end
    end

    def try_letter(letter)
      raise GameOver if(@word.failed?)
      @word.try(letter) unless(@word.guessed?)         

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
  end
end
