class Lanternfish
  attr_accessor :internal_timer

  def initialize(initial_timer = 8)
    @internal_timer = initial_timer
    @cycle_time = 7
  end

  def pass_day
    if @internal_timer.positive?
      @internal_timer -= 1
    else
      @internal_timer = @cycle_time - 1
    end
  end

  def create_lanternfish?
    @internal_timer.zero?
  end

  def to_s
    @internal_timer.to_s
  end
end
