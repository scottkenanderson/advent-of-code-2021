class Swarm
  def initialize
    @submarines = []
  end

  def add_submarine(submarine)
    @submarines << submarine
  end

  def calculate_linear_fuel(position)
    @submarines.map { |s| (s - position).abs }.sum
  end

  def calculate_summation_fuel(position)
    @submarines.map { |s| (s - position).abs }.map { |i| i * (i + 1) / 2 }.sum
  end

  def min
    @submarines.min
  end

  def max
    @submarines.max
  end

  def to_s
    @submarines.sort!.join(",")
  end
end
