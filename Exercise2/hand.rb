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

  CONFIGURATIONS = [
      {name: 'Royal Flush', strategy: :royal_flush?},
      {name: 'Straight Flush', strategy: :straight_flush?},
      {name: '4 of a Kind', strategy: :four_of_kind?},
      {name: 'Full House', strategy: :full_house?},
      {name: 'Flush', strategy: :flush?},
      {name: 'Straight', strategy: :straight?},
      {name: '3 of a Kind', strategy: :three_of_kind?},
      {name: '2 Pair', strategy: :two_pair?},
      {name: '1 Pair', strategy: :one_pair?}
  ]



  def initialize(cards)
    @cards = cards
  end

  def to_s
    "#{@cards.collect() { |card| card.to_s }.join(' ')} - #{strength}"
  end

  def strength
    order!

    attempt = 0
    begin
      match = self.send(CONFIGURATIONS[attempt][:strategy]) ? CONFIGURATIONS[attempt][:name] : nil
      attempt += 1
    end while attempt < CONFIGURATIONS.length && !match

    match || "High Card (#{high_card})"
  end

  def contains?(card)
    @cards.any? { |c| c == card }
  end

  def length
    @cards.length
  end

  # Static Public

  def self.parse(string)
    cards = string.split(' ').map { |str| Card.parse(str) }
    Hand.new(cards)
  end


  private


  def high_card
    order_by_rank[0]
  end


  def order!
    order_by_rank
  end

  def ranks
    @cards.map { |card| card.rank }
  end

  def all_same_suit?
    @cards.all? { |card| card.suit == @cards.first.suit }
  end

  def of_kind?(i, card_ranks)
    card_ranks[0..i - 1].all? { |rank| rank == card_ranks[0] }
  end

  def four_of_kind?
    of_kind? 4, ranks
  end

  def three_of_kind?
    !sequenced? && of_kind?(3, ranks[0..2])
  end

  def two_pair?
    !sequenced? && (of_kind?(2, ranks[0..1]) && of_kind?(2, ranks[2..3]))
  end

  def one_pair?
    !four_of_kind? && !three_of_kind? && !two_pair? && of_kind?(2, ranks[0..1])
  end

  def flush?
    all_same_suit? && (!royal_flush? && !straight_flush?)
  end

  def full_house?
    of_kind? 3, ranks[0..2] and of_kind? 2, ranks[3..4]
  end

  def straight?
    !all_same_suit? && sequenced?
  end

  def royal_flush?
    if all_same_suit?
      @cards[0..3].all? { |card| !card.numeric? } && @cards[4].rank == 10
    else
      false
    end
  end

  def straight_flush?
    if all_same_suit?
      @cards.all? { |card| card.numeric? } && sequenced?
    end
  end

  def sequenced?
    in_sequence = true
    @cards.each_with_index do |card, index |
      unless @cards[index +1 ].nil?
        in_sequence = in_sequence && @cards[index + 1].follows?(card)
      end
    end
    in_sequence
  end

  def order_by_rank
    @cards.sort!.reverse!
  end

end