class School
  @fishes = []

  def initialize
    @fishes = []
  end

  def add_fish(fish)
    @fishes << fish
  end

  def pass_day
    new_parents = @fishes.select(&:create_lanternfish?).map { |_| Lanternfish.new }
    @fishes.each(&:pass_day)
    @fishes += new_parents
  end

  def num_fish
    @fishes.length
  end

  def to_s
    @fishes.sort!.join(",")
  end
end
