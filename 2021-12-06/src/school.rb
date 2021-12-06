class School
  @fishes = []

  def initialize
    @fishes = []
    @days = 0
  end

  def add_fish(fish)
    @fishes << fish
  end

  def pass_day
    @days += 1
    new_fish = @fishes.select(&:create_lanternfish?).map { |_| Lanternfish.new }
    @fishes.each(&:pass_day)
    @fishes += new_fish
  end

  def num_fish
    @fishes.length
  end

  def to_s
    @fishes.sort!.join(",")
  end
end
