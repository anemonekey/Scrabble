require_relative 'spec_helper'

describe "Tilebag class" do
  before do
    @tilebag = Scrabble.Tilebag.new
  end
  describe "#initialize method" do
    it "Returns a collection of all default tiles" do
      @tilebag.tiles.class.must_be_kind_of Hash
    end
    it "Should not be an empty collection" do
      @tilebag.tiles.length.must_equal 26
    end
  end

  describe "#draw_tiles(num) method" do
    it "Returns a collection of random tiles" do
      @tilebag.draw_tiles(3).class.must_equal Array
    end
    it "Removes the drawn tiles from the tilebag" do
      before_remove = @tilebag.tiles
      @tilebag.draw_tiles(3)
      after_remove = @tilebag.tiles
      before_remove.wont_equal after_remove
    end
  end

  describe "#tiles_remaining method" do
    it "Must return an Integer value" do
      @tilebag.tiles_remaining.class.must_be_kind_of Integer
    end
    it "Must correctly return the number of tiles remaining" do
      # 98 total tiles
      @tilebag.draw_tiles(5)
      @tilebag.tiles_remaining.must_equal (98-5)
    end
  end
end
