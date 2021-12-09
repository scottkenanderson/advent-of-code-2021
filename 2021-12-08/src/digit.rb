require "set"

class Digit
  attr_accessor :segments

  def initialize(segments)
    @segments = segments
  end

  def length
    @segments.length
  end

  def convert(mapping)
    mapping[to_set] || @to_set
  end

  def value
    case @segments.length
    when 2
      return 1
    when 3
      return 7
    when 4
      return 4
    when 5
      # 2, 3, 5
      # if it contains 1, then 3
      # if it's a subset of 6, then 5
      #
      return "x"
    when 6
      # 0, 6, 9
      # if 6, and contains 4, then 9
      # if 6, and contains 7, then 0
      # else 6
      return "x"
    when 7
      return 8
    end
    "x"
  end

  def to_s
    @segments
  end

  def to_sorted_s
    @segments.chars.sort.join
  end

  def to_set
    @segments.chars.to_set
  end
end
