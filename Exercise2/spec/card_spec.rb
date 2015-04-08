require 'minitest/spec'
require 'minitest/autorun'

require_relative '../card.rb'

describe 'Playing Card' do

  describe 'instantiation' do

    describe 'with a valid suit and rank' do

      before(:all) do
        @valid_cards = [
          {rank: :king, suit: :clubs},
          {rank: 10, suit: :hearts},
          {rank: :ace, suit: :spades},
          {rank: 2, suit: :diamonds}
        ]
      end

      it 'successfully sets the card\'s suit' do
        @valid_cards.each do |card|
          card = Card.new(card[:rank], card[:suit])
          card.suit.wont_be_nil
        end
      end

      it 'successfully sets the card\'s rank' do
        @valid_cards.each do |card|
          card = Card.new(card[:rank], card[:suit])
          card.rank.wont_be_nil
        end
      end

    end

    describe 'with an invalid suit or rank' do

      before(:all) do
        @invalid_cards = [
            {rank: 0, suit: :clubs},
            {rank: 1, suit: :diamonds},
            {rank: :ace, suit: :cows}
        ]
      end

      it 'raises an exception' do
        @invalid_cards.each do |card|
          lambda { Card.new(card[:rank], card[:suit]) }.must_raise RuntimeError
        end
      end

    end

  end

  describe 'equality' do

    describe 'when both cards have numeric ranks' do
      describe 'when the left card has a higher rank than the right card' do
        it 'returns true' do
          (Card.new(8, :clubs) > Card.new(4, :diamonds)).must_equal true
        end
      end

      describe 'when the left card has a lower rank than the right card' do
        it 'returns false' do
          (Card.new(4, :spades) > Card.new(10, :hearts)).must_equal false
        end
      end
    end

   describe 'when one card has a numeric and the other does not' do
      describe 'when the card of the left is numeric and the card on the right is not' do
        it 'evaluates to false' do
          (Card.new(10, :clubs) > Card.new(:ace, :spades)).must_equal false
        end
      end

      describe 'when the card of the left is not numeric and the card on the right is' do
        it 'evaluates to true' do
          (Card.new(:king, :hearts) > Card.new(2, :diamonds)).must_equal true
        end
      end

    end

    describe 'when neither card has a numeric rank' do
      describe 'when the card on the right an ace and the card on the left is a king' do
        it 'returns true' do
          (Card.new(:ace, :spades) > Card.new(:king, :clubs))
        end
      end

      describe 'when the card on the right an king and the card on the left is a queen' do
        it 'returns true' do
          (Card.new(:king, :spades) > Card.new(:queen, :clubs))
        end
      end

      describe 'when the card on the right an queen and the card on the left is a jack' do
        it 'returns true' do
          (Card.new(:queen, :spades) > Card.new(:jack, :hearts))
        end
      end

      describe 'when the card on the right a jack and the card on the left is a King' do
        it 'returns false' do
          (Card.new(:jack, :diamonds) > Card.new(:king, :diamonds)).must_equal false
        end
      end

    end
  end

  describe 'casting to string' do
    it 'returns the string representation of the card' do
      "#{Card.new(:jack, :clubs)}".must_equal 'Jc'
    end
  end

end

