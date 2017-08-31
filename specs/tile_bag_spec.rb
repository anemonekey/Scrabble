require_relative 'spec_helper'

describe "TileBag class" do
  before do
    @tilebag = Scrabble::TileBag.new
  end
  describe "#initialize method" do
    it "Returns a collection of all default tiles" do
      @tilebag.tiles.must_be_kind_of Hash
    end
    it "Should not be an empty collection" do
      @tilebag.tiles.length.must_equal 26
    end
  end

  describe "#draw_tiles(num) method" do
    it "Returns a collection of random tiles" do
      @tilebag.draw_tiles(4).class.must_equal Array
    end
    it "Removes the drawn tiles from the tilebag" do
      before_remove = @tilebag.tiles.values
      @tilebag.draw_tiles(4)
      after_remove = @tilebag.tiles.values
      before_remove.wont_equal after_remove
    end
  end

  describe "#tiles_remaining method" do
    it "Must return an Integer value" do
      @tilebag.tiles_remaining.must_be_kind_of Integer
    end
    it "Must correctly return the number of tiles remaining" do
      @tilebag.draw_tiles(5)
      @tilebag.tiles_remaining.must_equal (98-5)
    end
  end
end
