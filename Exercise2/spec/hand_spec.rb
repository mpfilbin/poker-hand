require_relative 'spec_helper'
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

  describe 'casting to string' do
    it 'returns a string representation of the hand along with its strength' do
      (Hand.new(@cards).to_s).must_equal 'As Kh 10c 5d 2h - High Card (As)'
    end
  end

  describe 'ownership' do
    describe 'when asked about As' do
      it 'returns true' do
        @hand = Hand.new(@cards)
        @hand.contains?(Card.new(:ace, :spades)).must_equal true
      end
    end
    describe 'when asked about 5s' do
      it 'returns false' do
        @hand = Hand.new(@cards)
        @hand.contains?(Card.new(6, :spades)).must_equal false
      end
    end
  end

  describe 'determining hand strength' do

    describe 'When given Ah Kh Qh Jh 10h' do
      it 'returns royal flush' do
        Hand.parse('Ah Kh Qh Jh 10h').strength.must_equal 'Royal Flush'
      end
    end

    describe 'when given 8s 7s 6s 5s 4s' do
      it 'returns straight flush' do
        Hand.parse('8s 7s 6s 5s 4s').strength.must_equal 'Straight Flush'
      end
    end

    describe 'when given 5h 5s 5h 5c 3h' do
      it 'returns 4 of a Kind' do
        Hand.parse('5h 5s 5h 5c 3h').strength.must_equal '4 of a Kind'
      end
    end

    describe 'when given Kh Kd Ks 5h 5c' do
      it 'returns Full House' do
        Hand.parse('Kh Kd Ks 5h 5c').strength.must_equal 'Full House'
      end
    end

    describe 'when given Ks Js 9s 7s 3s' do
      it 'returns flush' do
        Hand.parse('Ks Js 9s 7s 3s').strength.must_equal 'Flush'
      end
    end

    describe 'when given Qs Jd 10c 9s 8h' do
      it 'returns Straight' do
        Hand.parse('Qs Jd 10c 9s 8h').strength.must_equal 'Straight'
      end
    end

    describe 'when given Qs Qh Qd 5s 9c' do
      it 'returns 3 of a kind' do
        Hand.parse('Qs Qh Qd 5s 9c').strength.must_equal '3 of a Kind'
      end
    end

    describe 'when given Kh Ks Jc Jd 9d' do
      it 'returns 2 Pair' do
        Hand.parse('Kh Ks Jc Jd 9d').strength.must_equal '2 Pair'
      end
    end

    describe 'when given As Ad 9h 6s 4d' do
      it 'returns 1 Pair' do
        Hand.parse('As Ad 9h 6s 4d').strength.must_equal '1 Pair'
      end
    end

    describe 'when given Ad 7h 5c 3d 2s' do
      it 'returns High Card' do
        Hand.parse('Ad 7h 5c 3d 2s').strength.must_equal 'High Card (Ad)'
      end
    end
  end

  describe 'string parsing' do
    describe 'when given 4c Ks 9h Jc 2d' do
      before(:all) do
        @hand = Hand.parse('4c Ks 9h Jc 2d')
      end

      it 'contains 5 cards' do
        @hand.length == 5
      end

      it 'contains all of the cards described in the string' do
        @cards = '4c Ks 9h Jc 2d'.split(' ').map {|string| Card.parse(string)}
        @cards.each do |card|
          @hand.contains?(card).must_equal true
        end
      end
    end
  end

end