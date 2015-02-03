require "sqlite3"
require_relative "../source/DB.rb"
require_relative "../source/Word.rb"

describe RBHangman::Word do
  before :each do
    query = "INSERT INTO DICTIONARY VALUES ('DICTIONARY')"
    SQLite3::Database.new("./rbhangman.db").execute(query)
    @word = RBHangman::Word.new
  end

  after :each do
    query = "DELETE FROM DICTIONARY"
    SQLite3::Database.new("./rbhangman.db").execute(query)
  end

  describe "#guessed?" do
    it "returns false if the word is not guessed" do
      expect(@word.guessed?).to eq false
    end

    it "returns true when all of the letters are revealed" do
      word = ['D','I','C','T','I','O','N','A','R','Y']
      word.each do |letter|
        @word[letter]
      end
      expect(@word.revealed).to eq word
    end
  end

  describe "#failed?" do
    it "returns false if the word has not failed" do
      expect(@word.failed?).to eq false
    end

    it "returns true when 10 times wrong letter is entered" do
      (1..10).each { |_| @word['z'] }
      expect(@word.failed?).to eq true
    end

  end

  describe "#revealed" do
    it "has correct list of underlines for a given word from the DB" do
      expect(@word.revealed.length).to eq 10
    end
  end

  describe "#[]" do
    it "has correctly defined '[]' method for letter guessing" do
      @word['I']
      expect(@word.revealed).to eq ['_', 'I', '_', '_', 'I', '_', '_', '_', '_', '_']
    end
  end

  describe "#used" do
    it "saves used letters in an array correctly" do
      @word['a']
      @word['z']
      expect(@word.used).to eq ['A', 'Z']
    end
  end
end
