require "sqlite3"
require_relative "../source/DB.rb"
require_relative "../source/Word.rb"
require_relative "../source/Player.rb"
require_relative "../source/Game.rb"

describe "RBHangma::Game" do
  before :each do
    ('A'..'K').each.with_index do |letter, index|
      query = "INSERT INTO HIGHSCORES VALUES ('#{letter.upcase * 3}', #{index});"
      SQLite3::Database.new("./rbhangman.db").execute(query)
    end
    SQLite3::Database.new("./rbhangman.db")
                     .execute("INSERT INTO DICTIONARY VALUES ('BANANA')")
    @game = RBHangman::Game.new
  end

  after :each do
    SQLite3::Database.new("./rbhangman.db")
                     .execute("DELETE FROM HIGHSCORES;")
    SQLite3::Database.new("./rbhangman.db")
                     .execute("DELETE FROM DICTIONARY;")
  end

  describe "#highscores" do
    it "displays the first 10 best scores" do
      expect(@game.highscores.length).to eq 10
    end
  end

  describe "#add_word" do
    it "can add word correctly to database" do
      @game.add_word("MUFFIN")
      expect(SQLite3::Database.new("./rbhangman.db")
                              .execute("SELECT * FROM DICTIONARY WHERE WORD='MUFFIN'")).not_to eq []
    end
  end

  describe "#in_database?" do
    it "returns true if the word exists in the database" do
      expect(@game.in_database?("BANANA")).to eq true
    end
    it "returns false if the word does not exist in the database" do
      expect(@game.in_database?("NOTHING")).to eq false
    end
  end
end
