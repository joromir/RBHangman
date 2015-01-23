require "sqlite3"
require "./source/DB.rb"
require "./source/Word.rb"
require "./source/Player.rb"
require "./source/Game.rb"

module RBHangman
  class CLI
    attr_accessor :player # ????

    def initialize(game = Game.new)
      @game = game
      @player = game.player
      login
    end

    def login
      clear
      puts "\nusername:"
      username = gets.chomp
      if(username == "")
        @player.name = "GUEST"
      else
        @player.name = username.upcase
      end
      menu
    end

    def menu
      clear
      puts "Welcome, #{@player.name}"
      puts "\nMAIN MENU\n\n"
      puts "[1] NEW GAME"
      puts "[2] HIGHSCORES"
      puts "[3] ADD A NEW WORD TO DICTIONARY"
      puts "[4] QUIT GAME"
      case gets.chomp
      when '1' then new_game
      when '2' then highscores
      when '3' then new_word
      when '4' then quit_game
      else menu
      end
    end

    def quit_game
      clear
      exit
    end

    def clear
      system "clear"
    end

    def highscores
      clear
      result = []
        @game.highscores.each.with_index do |row, index|
        result << (index + 1).to_s + ". " + row[0].to_s + " " + row[1] + "\n"
      end
      puts "\nHIGHSCORES:\n\n" + result.join
      puts "-" * 10
      puts "[1] BACK"
      puts "[2] QUIT GAME"

      case gets.chomp
      when '1' then menu
      when '2' then quit_game
      else highscores
      end
    end

    def new_game
      while(true) do
        clear
        wrong = "[WRONG: #{@player.word.wrong}]"
        if(@player.word.used != [])
          used = "[USED LETTERS: #{@player.word.used.reduce(&:+).upcase}]"
        else
          used = "[USED LETTERS: <<empty>>]"
        end
        puts figure(@player.word.wrong)
        puts wrong + used
        puts "[SCORE: #{@player.score}]" + "[USERNAME: #{@player.name}]"
        puts @player.word.revealed.inspect
        begin
          insert_letter
          @player.new_word if(@player.word.guessed?)
        rescue GameOver => ex
          clear
          figure(@player.word.wrong)
          puts ex.message
          break      
        end
      end
      exit
    end

    def insert_letter
      puts "letter:"
      get = STDIN.first.chomp
      if(/^[a-zA-Z]$/.match get)
        @player[get]
      else
        insert_letter
      end
    end

    def figure(index)
      part =  "  _______\n |/      |\n |      (.)\n |"
      part2 = "      \\|/\n |       |\n |      "
      ascii_image = [("\n" * 8),
                    ("\n" * 7) + "_|___"  + "\n",
                     "  __\n |/\n " + ("|\n " * 4) + "|\n_|___\n",
                     "  _______\n |/\n |\n |\n |\n |\n | \n_|___\n",
                     "  _______\n |/      |\n |\n |\n |\n |\n |\n_|___",
                     part + "\n |\n |\n |\n_|___",
                     part + "       |\n |       |\n |       '\n |\n_|___",
                     part + "      \\|\n |       |\n |       '\n |\n_|___",
                     part + part2 + " '\n |\n_|___",
                     part + part2 +"/'\n |\n_|___",
                     part + part2 + "/'\\\n |\n_|___"]
      puts ascii_image[index]
    end
  end
end
