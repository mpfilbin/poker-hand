require 'minitest/spec'
require 'minitest/autorun'

require_relative '../hand.rb'

describe 'A player\s hand' do
  before(:all) do
    @cards = [
        Card.new(:ace, :spades),
        Card.new(:king, :hearts),
        Card.new(10, :clubs),
        Card.new(5, :diamonds),
        Card.new(2, :hearts)
    ]
  end


  describe 'when instantiated with fewer than five cards' do
    it 'is not valid' do
      Hand.new(@cards[0..3]).valid?.must_equal false
    end
  end

  describe 'casting to string' do
    it 'returns a string representation of the hand' do
      (Hand.new(@cards).to_s).must_equal 'As Kh 10c 5d 2h'
    end
  end

  describe 'ordering hand' do
    it 'should order the hand by the rank of the card' do
      @hand = Hand.new(@cards)
      @hand.order!
      @hand.to_s.must_equal 'As Kh 10c 5d 2h'
    end
  end

  describe 'determining if hand is of the same suit' do
    describe 'when cards are all same suit' do
      it 'returns true' do
        @hand = Hand.new([
                             Card.new(10, :hearts),
                             Card.new(2, :hearts),
                             Card.new(:ace, :hearts),
                             Card.new(4, :hearts),
                             Card.new(:jack, :hearts)
                         ])
        @hand.all_same_suit?.must_equal true
      end
    end

    describe 'when the cards are of differing suits' do
      it 'returns false' do
        @hand = Hand.new(@cards)
        @hand.all_same_suit?.must_equal false
      end
    end
  end

  describe 'asking for all of the hands\'s ranks' do
    it 'returns an array of its card\'s ranks' do
      @hand = Hand.new(@cards)
      (@hand.ranks - [:ace, :king, 10, 5, 2]).must_be_empty
    end
  end

  describe 'getting the high card' do
    it 'returns the card with the highest rank' do
      @hand = Hand.new(@cards)
      @hand.high_card.to_s.must_equal 'As'
    end
  end

end