require "sqlite3"
require "./source/DB.rb"
require "./source/Word.rb"
require "./source/Player.rb"
require "./source/Game.rb"

module RBHangman
  class GUI
    @@logged = false

    class << self
      def menu
        Shoes.app do
          background "./images/0.jpg"
          background "./images/10.png"
          stack do
            title "RBHangman", align: 'center'
          end

          stack(top:120, left: 370) do
            button "Login" do
              if(@@logged == false and @name == nil)
                @name = ask("Username:").upcase
                @@logged = true
                para(strong(@name), top: 120, left: 465)
              else
                alert "Already logged in! Username: #@name"
              end
            end

            button "New game" do
              alert "Under construction"
            end
            
            button "Highscores" do
             GUI.highscores
            end
            
            button "Add new word" do
              alert "Under construction"
            end

            button "Exit" do
              alert "Goodbye!"
              exit
            end
          end
        end
      end

      def highscores
        Shoes.app do
          background "./images/0.jpg"
          output = ""
          Game.new.highscores.each.with_index do |row, index|
            output = output + (index + 1).to_s + ".  " + row.to_s.gsub("[", "").gsub("]", "") + "\n"
          end
          stack(margin: 10) do
            title "Highscores"
            para(strong(output))
          end
        end
      end

    end
  end
end

RBHangman::GUI.menu
