class Card
  include Comparable

  # rank: A > K > Q > J > 10 .. 2

  RANK_PATTERN = /^([0-9]{0,2}|[jkqa])\w$/
  SUIT_PATTERN =/^*?([hdsc]{1})$/
  NON_NUMERICS = %w( a k q j )

  VALID_RANKS = [*2..10].concat(NON_NUMERICS)

  attr_reader :suit, :rank

  def initialize(representation)
    parse(representation)
  end

  def to_s
    "#{rank.to_s.upcase}#{suit}"
  end

  def numeric?
    rank.is_a? Numeric
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
      int = NON_NUMERICS.find_index {|rank| rank == other.rank} <=> NON_NUMERICS.find_index {|rank| rank == self.rank}
    end
    int
  end

  private

  def parse(representation)
    raise ArgumentError, "#{representation} must be a string" unless representation.is_a? String
    @suit = get_suit(representation)
    @rank = get_rank(representation)
  end

  def get_rank(representation)
    match = RANK_PATTERN.match(representation.downcase)
    raise "#{representation} does not have a valid rank" if match.nil? or !VALID_RANKS.any? { |rank| rank.to_s == match[1] }
    match[1].to_i > 0 ? match[1].to_i : match[1]
  end

  def get_suit(representation)
    match = SUIT_PATTERN.match(representation.downcase)
    raise "#{representation} does not have a valid suit" if match.nil?
    match
  end
end