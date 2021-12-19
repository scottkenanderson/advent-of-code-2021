class Probe
  attr_accessor :point, :speed, :initial_speed

  def initialize(x_speed, y_speed)
    @point = Point.new(0, 0)
    @initial_speed = Point.new(x_speed, y_speed)
    @speed = Point.new(x_speed, y_speed)
  end

  def calculate_speed(speed)
    return 0 if speed == 0
    return speed - 1 if speed.positive?
    speed + 1 if speed.negative?
  end

  def change_speed
    x_speed = calculate_speed(@speed.x)
    y_speed = @speed.y - 1
    @speed = Point.new(x_speed, y_speed)
  end

  def step
    @point += @speed
    change_speed
  end

  def to_s
    "Speed: #{@speed}, Point: #{@point}"
  end
end
