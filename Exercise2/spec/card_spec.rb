require_relative 'spec_helper'

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

  describe 'numericality' do

    describe '10h' do
      it 'is numeric' do
        Card.new(10, :hearts).numeric?.must_equal true
      end
    end

    describe 'As' do
      it 'is not numeric' do
        Card.new(:ace, :spades).numeric?.must_equal false
      end
    end

  end

  describe 'string parsing' do
    describe 'As' do
      before(:all) do
        @card = Card.parse('As')
      end
      it 'parses to Ace of Spades' do
        (@card == Card.new(:ace, :spades)).must_equal true
      end

      it 'does not parse to King of Diamonds' do
        (@card == Card.new(:king, :diamonds)).must_equal false
      end

    end

    describe '10h' do
      before(:all) do
        @card = Card.parse('10h')
      end
      it 'parses to 10 of Hearts' do
        (@card == Card.new(10, :hearts)).must_equal true
      end

      it 'does not parse to 2 of Clubs' do
        (@card == Card.new(2, :clubs)).must_equal false
      end

    end
  end

  describe 'ranking' do
    describe 'Qh' do
      before(:all) do
        @card = Card.parse('Qh')
      end

      it 'follows Kd' do
        @card.follows?(Card.parse('Kd')).must_equal true
      end

      it 'does not follow Ah' do
        @card.follows?(Card.parse('Ah')).must_equal false
      end

      it 'does not follow Js' do
        @card.follows?(Card.parse('Js')).must_equal false
      end

    end

  end


end

