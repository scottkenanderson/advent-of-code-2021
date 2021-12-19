require_relative "../../lib/point"

class TargetArea
  attr_accessor :min_point, :max_point

  def initialize(x_min, x_max, y_min, y_max)
    x_min = x_min.to_i
    x_max = x_max.to_i
    y_min = y_min.to_i
    y_max = y_max.to_i

    @min_point = Point.new([x_min, x_max].min, [y_min, y_max].min)
    @max_point = Point.new([x_min, x_max].max, [y_min, y_max].max)
  end

  def contains(probe)
    point = probe.point
    point.x >= @min_point.x && point.x <= @max_point.x && point.y >= @min_point.y && point.y <= @max_point.y
  end

  def to_s
    "Min: #{@min_point}, Max: #{@max_point}"
  end
end
