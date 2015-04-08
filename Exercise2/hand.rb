require_relative 'card'


class Hand

=begin

Royal Flush: Contains five cards, A, K, Q, J, 10, all of the same suit
Straight Flush: Contains five cards, 9-2, all same suit
4 of a Kind: Contains four of five cards all of the same rank, suits can differ
Full House: Three of a Kind and a Pair
Flush: All five cards of the same suit but not in sequence
Straight: Five sequential cards in at least two different suites
3 of a Kind: Three cards of the same rank, suites can differ
2 Pair: Two sets of same rank cards, suits can differ
1 Pair: Two cards with matching ranks, suits can differ
High Card: Any five cards not matching the above

=end


  def initialize(hand_as_string)
    @cards = build_hand(hand_as_string)
    raise "#{hand_as_string} must have five cards" unless @cards.size == 5
  end

  def to_s
    @cards.collect() {|card| card.to_s}.join(' ')
  end


  def sequence!
    group_suits
    order_by_rank
  end

  def all_same_suit
    @cards.all? {|card| card.suit == @cards.first.suit}
  end


  private

  def build_hand(hand_as_string)
    cards = hand_as_string.split(' ')
    cards.map{|card| Card.new(card)}
  end

  def order_by_rank
    @cards.sort!
  end

  def group_suits
    @cards.group_by {|card| card.suit}.to_a
  end

end