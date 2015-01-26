require "sqlite3"
require "./source/DB.rb"
require "./source/Word.rb"
require "./source/Player.rb"
require "./source/Game.rb"

Shoes.app(title: "RBHangman") do
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

    def menu
      Shoes.app(title: "RBHangman | Main Menu")do
        background "#FFF"
        background "./images/0.jpg"
        title("RBHangman", align: 'center', top: 25)
        image "./images/10.png", top: 25, left: 10

        stack(top:160, left: 370) do

          para strong("Username: #{@@game.player.name}")

          button "New Game" do
            Actions.new_game
            #close
          end

          button "New Word" do
            alert "under construction"
          end

          button "Highscores" do
            Actions.highscores
          end

          button "About" do
            info = "Programming in Ruby course project"
            alert info + "\nCreated by: Georgi Kostov"
          end

          button "Exit" do
            exit
          end
        end
      end
    end

    def self.new_game

      Shoes.app(title: "RBHangman") do
        background "#FFF"
        background "./images/0.jpg"
        background "./images/#{@@game.player.word.wrong}.png"

        word_view = @@game.player.word.revealed.map do |letter|
          letter = "#{letter} "
        end.reduce(&:+)

        title("#{word_view}", align: 'center', top: 400)

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

        stack(top:260, left: 280) do
          letter = edit_line
          button "GO" do
            @@game.player[letter.text]

            if(@@game.player.word.guessed?)
              the_word = @@game.player.word.revealed.reduce(&:+)
              alert "Good job, the word is #{the_word}"
              @@game.player.new_word
            end 
            Actions.new_game
            close
          end
        end
      end
    end

    def self.highscores
      Shoes.app do
        background "#FFF"
        background "./images/0.jpg"
        title "HIGHSCORES", align: "left", top: 20, margin: 10
        stack(margin: 30, top: 60) do
          output = ""
          @@game.highscores.each.with_index do |row, index|

            output = output + (index + 1).to_s + ". " + 
                     row[1] + ' (' + row[0].to_s + ")" + "\n"
          end
          para strong(output)
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
    stack do
      username = edit_line

      button "Login" do
        if(username.text != "")
          @my_actions.do_login(username.text.upcase)
        else
          @my_actions.do_login("GUEST")
        end
        @my_actions.menu
        close
      end
    end
  end
end
