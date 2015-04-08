class Card
  include Comparable

  # rank: A > K > Q > J > 10 .. 2

  VALID_NON_NUMERIC_RANKS = %i( ace king queen jack )
  VALID_SUITS = %i( clubs spades diamonds hearts )

  attr_reader :suit, :rank

  def initialize(rank, suit)
    set_rank(rank)
    set_suit(suit)
  end

  def to_s
    if rank.is_a? Numeric
      ranks_string = rank.to_s
    else
      ranks_string = rank.to_s[0].upcase
    end
    "#{ranks_string}#{suit.to_s[0]}"
  end

  def <=> (other)
    # if we're both numeric, then other must be less than
    # If I'm numeric and the other is not, then other is greater
    # if other is numeric and I am not, then I am greater
    # if neither is numeric, then A > K > Q > J

    if other.numeric? and self.numeric?
      int = self.rank <=> other.rank
    elsif other.numeric? and !self.numeric?
      int = 1
    elsif !other.numeric? and self.numeric?
      int = -1
    else
      int = VALID_NON_NUMERIC_RANKS.find_index { |rank| rank == other.rank } <=> VALID_NON_NUMERIC_RANKS.find_index { |rank| rank == self.rank }
    end
    int
  end

  protected

  def numeric?
    rank.is_a? Numeric
  end


  private

  def set_rank(rank)
    if rank.is_a? Numeric
      raise "#{rank} is an invalid rank" unless (2..10).include? rank
    elsif rank.is_a? Symbol
      raise "#{rank} is an invalid rank" unless VALID_NON_NUMERIC_RANKS.include? rank
    else
      raise ArgumentError, 'rank must be either a Numeric or Symbolic value'
    end
    @rank = rank
  end


  def set_suit(suit)
    raise "#{suit} is not a valid suit" unless suit.is_a? Symbol and VALID_SUITS.include? suit
    @suit = suit
  end

end