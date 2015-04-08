require 'minitest/spec'
require 'minitest/autorun'

require_relative '../hand.rb'

describe 'A player\s hand' do

  describe 'when instantiated with fewer than five cards' do
    it 'raises an exception' do
      lambda {Hand.new('As Kh 10c 5d')}.must_raise RuntimeError
    end
  end

  describe 'stringification' do
    it 'returns a string representation of the hand' do
      (Hand.new('as kh 10c 4d 2c').to_s).must_equal 'As Kh 10c 4d 2c'
      puts Hand.new('as ks 10c 3c 2d').sequence!
    end
  end

end