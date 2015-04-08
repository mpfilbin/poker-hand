require 'minitest/spec'
require 'minitest/autorun'

require_relative '../card.rb'

describe 'Playing Card' do

  describe 'instantiation' do

    describe 'without a string representation' do
      it 'raises an exception' do
        lambda { Card.new }.must_raise ArgumentError
      end
    end

    describe 'with a valid suit and rank' do

      before(:all) do
        @valid_representations = %w( as kh jd qc 5h 10d 6s 8c)
      end

      it 'successfully sets the card\'s suit' do
        @valid_representations.each do |rep|
          card = Card.new(rep)
          card.suit.wont_be_nil
        end
      end

      it 'successfully sets the card\'s rank' do
        @valid_representations.each do |rep|
          card = Card.new(rep)
          card.rank.wont_be_nil
        end
      end

    end

    describe 'with an invalid suit or rank' do

      before(:all) do
        @invalid_representations = %w( 0c 1h qz )
      end

      it 'raises an exception' do
        @invalid_representations.each do |rep|
          lambda { Card.new(rep) }.must_raise RuntimeError
        end
      end

    end

  end

  describe 'numericality' do
    describe '10c' do
      it 'is numeric' do
        Card.new('10c').numeric?.must_equal true
      end
    end

    describe 'ah' do
      it 'is not numeric' do
        Card.new('ah').numeric?.must_equal false
      end
    end

  end

  describe 'equality' do

    describe 'when both cards have numeric ranks' do
      describe 'when the left card has a higher rank than the right card' do
        it 'returns true' do
          (Card.new('8c') > Card.new('4d')).must_equal true
        end
      end

      describe 'when the left card has a lower rank than the right card' do
        it 'returns false' do
          (Card.new('4s') > Card.new('10h')).must_equal false
        end
      end
    end

    describe 'when one card has a numeric and the other does not' do
      describe 'when the card of the left is numeric and the card on the right is not' do
        it 'evaluates to false' do
          (Card.new('10c') > Card.new('as')).must_equal false
        end
      end

      describe 'when the card of the left is not numeric and the card on the right is' do
        it 'evaluates to true' do
          (Card.new('kh') > Card.new('2d')).must_equal true
        end
      end

    end

    describe 'when neither card has a numeric rank' do
      describe 'when the card on the right an ace and the card on the left is a king' do
        it 'returns true' do
          (Card.new('as') > Card.new('kc'))
        end
      end

      describe 'when the card on the right an king and the card on the left is a queen' do
        it 'returns true' do
          (Card.new('ks') > Card.new('qc'))
        end
      end

      describe 'when the card on the right an queen and the card on the left is a jack' do
        it 'returns true' do
          (Card.new('qs') > Card.new('jc'))
        end
      end

      describe 'when the card on the right a jack and the card on the left is a King' do
        it 'returns false' do
          (Card.new('js') > Card.new('kc')).must_equal false
        end
      end

    end
  end

  describe 'stringification' do
    it 'returns the string representation of the card' do
      "#{Card.new('Jc')}".must_equal 'Jc'
    end
  end


end

