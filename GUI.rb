require "sqlite3"
require "./source/DB.rb"
require "./source/Word.rb"
require "./source/Player.rb"
require "./source/Game.rb"

Shoes.app do
  class Actions
    @@game = RBHangman::Game.new

    def initialize(app)
      @my_app = app
    end

    def do_login(username)
      @my_app.app do
        @@game.player.name = username
        alert "Welcome, #{@@game.player.name}"
      end
    end

    def add_word
      @my_app.app do
        word = ask("New word:").upcase
        if(@@game.in_database?(word))
          alert "Word '#{word.upcase}' already added!"
        else
          @@game.add_word(word)
        end
      end
    end

    def menu
      @my_app.app do
        clear
        background "./images/0.jpg"


        title("RBHangman", align: 'center', top: 25)
        para strong("Username: #{@@game.player.name}")
        image "./images/10.png"

        stack(top:160, left: 370) do
          button "New Game" do
            @my_actions.new_game
          end

          button "Highscores" do
            @my_actions.highscores
          end

          button "Add word" do
            @my_actions.add_word
          end

          button "About" do
            info = "Programming in Ruby course project"
            alert info + "\nCreated by: Georgi Kostov"
          end

          button "Exit" do
            @@game.player.save_highscore
            exit
          end
        end
      end
    end

    def highscores
      @my_app.app do
        clear
        background "#FFF"
        background "./images/0.jpg"

        stack(margin: 30) do
          title "HIGHSCORES", align: "left", top: 20

          output = ""
          @@game.highscores.each.with_index do |row, index|
            output = output + (index + 1).to_s + ". " +
                     row[1] + ' (' + row[0].to_s + ")" + "\n"
          end
          para(strong(output), top: 90)
        end

        stack(top: 400, left: 30) do
          button "Menu" do
            @my_actions.menu
          end
          button "Exit" do
            exit
          end
          para strong("Username: #{@@game.player.name}")
        end
      end
    end

    def new_game
      @my_app.app do
        clear
        background "#FFF"
        background "./images/0.jpg"

        word_view = @@game.player.word.revealed.map do |letter|
          letter = "#{letter} "
        end.reduce(&:+)

        title("#{word_view}", align: 'center', top: 400)
        button "Save highscore and exit" do
          @@game.player.save_highscore
          exit
        end

        stack(top:60, left: 280) do
          used = @@game.player.word.used.to_s.gsub("[", "")
                                             .gsub("]", "")
                                             .gsub("\"", "")
          para strong("USERNAME: #{@@game.player.name}")
          para strong("SCORE: #{@@game.player.score}")
          para strong("WRONG: #{@@game.player.word.wrong}")
          para strong("USED: #{used}",
                      left: 10,
                      top: 10)
        end

        image "./images/#{@@game.player.word.wrong}.png", top: 10, left: 30

        stack(top:260, left: 280) do
          letter = edit_line

          button "Enter" do
            if(@@game.player.word.failed?)
              clear
              @@game.player.save_highscore
              background "#FFF"
              background "./images/0.jpg"
              title "GAME OVER", align: 'center', top: 30
              image "./images/10.png", top: 30, left: 30
            end

            @@game.player[letter.text.upcase]

            if(@@game.player.word.guessed?)
              the_word = @@game.player.word.revealed.reduce(&:+)
              alert "Good job, the word is #{the_word}"
              @@game.player.new_word
            end

            @my_actions.new_game
          end
        end
      end
    end
  end

  background "./images/0.jpg"
  image "./images/10.png"

  stack do
    title("RBHangman", align: 'center', top: 30)
  end

  stack(top:120, left: 370) do
    @my_actions = Actions.new(self)

    stack(left:10, top: 110) do
      username = edit_line

      button "Login" do
        if(username.text != "")
          @my_actions.do_login(username.text.upcase)
        else
          @my_actions.do_login("GUEST")
        end
        @my_actions.menu
      end
    end
  end
end
