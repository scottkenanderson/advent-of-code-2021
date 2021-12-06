class SchoolOptimized
  @fishes = {}

  def initialize
    @fishes = {}
    (0..8).each { |i| @fishes[i] = 0 }
    @days = 0
  end

  def add_fish(fish)
    @fishes[fish.internal_timer] += 1
  end

  def pass_day
    @days += 1

    new_fish = @fishes[0]
    (1..8).each { |i| @fishes[i - 1] = @fishes[i] }
    @fishes[8] = new_fish
    @fishes[6] += new_fish
  end

  def num_fish
    total = 0
    @fishes.each_value { |v| total += v }
    total
  end

  def to_s
    @fishes.to_s
  end
end
