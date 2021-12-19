require_relative "./trench_grid_point"
require_relative "../../lib/grid"

class Trench < Grid
  def initialize(target_area, points)
    @min_x_point = [points.map(&:x).min, target_area.min_point.x].min
    @max_x_point = [points.map(&:x).max, target_area.max_point.x].max
    @min_y_point = [points.map(&:y).min, target_area.min_point.y].min
    @max_y_point = [points.map(&:y).max, target_area.max_point.y].max

    puts [@min_x_point, @max_x_point, @min_y_point, @max_y_point].join(" ")
    grid = []
    (@min_y_point..@max_y_point).each do |y|
      grid << (@min_x_point..@max_x_point).map { |_| TrenchGridPoint.new(".") }
    end
    super(grid)
  end

  def mark(point, character)
    offset_x = @min_x_point.abs + point.x
    offset_y = point.y + @min_y_point.abs
    retrieve(Point.new(offset_x, offset_y)).mark = character
  end

  def to_s
    @grid.reverse.map { |y| y.map(&:to_s).join(" ") }.join("\n")
  end
end
