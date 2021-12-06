class SchoolOptimized
  def initialize
    @cycle_index = 7
    @first_cycle_index = @cycle_index + 2
    @fishes = (0..@first_cycle_index).map { |_| 0 }
  end

  def add_fish(fish)
    @fishes[fish.internal_timer] += 1
  end

  def pass_day
    new_fish = @fishes.shift
    @fishes << new_fish
    @fishes[@cycle_index] += new_fish
  end

  def num_fish
    @fishes.sum
  end

  def to_s
    @fishes.join(",")
  end
end
