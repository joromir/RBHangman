require "sqlite3"
require_relative "../source/DB.rb"
require_relative "../source/Word.rb"
require_relative "../source/Player.rb"

describe "RBHangman::Player" do
  before :each do
    SQLite3::Database.new("./rbhangman.db")
                     .execute("INSERT INTO DICTIONARY VALUES ('BANANA')")
    @player = RBHangman::Player.new
    @player.name = "GUEST"
  end

  after :each do
    SQLite3::Database.new("./rbhangman.db").execute("DELETE FROM HIGHSCORES;")
    SQLite3::Database.new("./rbhangman.db").execute("DELETE FROM DICTIONARY;")
  end

  describe "#failed?" do
    it "shows corectly if player has failed or not" do
      expect(@player.failed?).to eq false
    end
  end

  describe "#word" do
    it "returns the word given to the player" do
      expect(@player.word.revealed).to eq ['_', '_', '_', '_', '_', '_']
    end
  end

  describe "#[]" do
    it "can insert letter by '[]' method" do
      @player['a']
      expect(@player.word.revealed).to eq ['_', 'A', '_', 'A', '_', 'A']
    end
  end

  describe "#score" do
    it "returns corectly the score of the player" do
      expect(@player.score).to eq 0
    end
  end

  describe "#save_highscore" do
    it "saves corectly highscore for new user" do
      SQLite3::Database.new("./rbhangman.db").execute("DELETE FROM HIGHSCORES;")
      @player.save_highscore
      expect(SQLite3::Database.new("./rbhangman.db").execute("SELECT * FROM HIGHSCORES")).not_to eq []
    end
    it "saves corectly highscore for user" do
      @player.save_highscore
      @player.instance_variable_set(:@score, 4)
      @player.save_highscore
      expect(SQLite3::Database.new("./rbhangman.db").execute("SELECT * FROM HIGHSCORES WHERE player='GUEST' AND score=4")).not_to eq []
    end
  end
end
