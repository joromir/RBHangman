module RBHangman
  class Added < StandardError
  end

  class Game < DB
    attr_accessor :player

    def in_database?(word)
      has_record?('DICTIONARY', word, 'WORD')
    end

    def add_word(word)
      if(in_database?(word))
        raise Added, "'#{word.upcase}' already added"
      else
        inserter('DICTIONARY', "'#{word.upcase}'", 'WORD')
      end
    end

    def highscores
      result = selector('SCORE ,PLAYER',
                        'HIGHSCORES',
                        nil,
                        'SCORE DESC')
      result[0...10]
    end

    private

    def initialize
      @player = Player.new
    end
  end
end
