module RBHangman
  class Game < DB
    attr_accessor :player

    def in_database?(word)
      has_record?('DICTIONARY', word, 'WORD')
    end

    def add_word(word)
      if(in_database?(word) or word == "")
        raise ArgumentError, "Incorrect input entered!"
      else
        inserter('DICTIONARY', "'#{word.upcase}'", 'WORD')
      end
    end

    def highscores
      result = selector('SCORE ,PLAYER',
                        'HIGHSCORES',
                        nil,
                        'SCORE DESC')
      result[0..10]
    end

    def initialize
      @player = Player.new
    end

    def select_player(name)
      @player.name = name.upcase
    end

    def player_name
      @player.name
    end
  end
end
