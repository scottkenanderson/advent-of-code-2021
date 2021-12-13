# frozen_string_literal: true

require_relative "../../lib/grid"
require_relative "../../lib/point"

class TransparentPaper < Grid
  def initialize(dots)
    super(dots)
  end

  def mark(dot)
    @grid[dot.y][dot.x] = "#"
  end

  def is_marked?(point)
    @grid[point.y][point.x] == "#"
  end

  def fold_horizontal(position)
    (position..y_length - 1).each do |y|
      (0..x_length - 1).each do |x|
        point = Point.new(x, y)
        if is_marked?(point)
          mark(Point.new(x, position - (y - position)))
        end
      end
    end
    @grid = @grid.slice(0, position)
  end

  def fold_vertical(position)
    (0..y_length - 1).each do |y|
      (position..x_length - 1).each do |x|
        point = Point.new(x, y)
        if is_marked?(point)
          mark(Point.new(position - (x - position), y))
        end
      end
    end
    @grid = @grid.map { |array| array.slice(0, position) }
  end

  def fold(instruction)
    if instruction.horizontal?
      fold_horizontal(instruction.position)
    end

    if instruction.vertical?
      fold_vertical(instruction.position)
    end
  end

  def count_dots
    counted = @grid.map do |row|
      row.select { |col| col == "#" }.length
    end
    counted.sum
  end
end
