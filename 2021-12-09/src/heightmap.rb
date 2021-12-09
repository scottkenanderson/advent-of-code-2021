# frozen_string_literal: true

require_relative "../../lib/point"

class Heightmap
  def initialize(grid)
    @grid = grid
  end

  def valid_location?(point)
    point.x >= 0 && point.y >= 0 && point.x < @grid[0].length && point.y < @grid.length
  end

  def value_at(point)
    return nil unless valid_location?(point)

    @grid[point.y][point.x]
  end

  def get_immediate_neighbours(point)
    i = point.x
    j = point.y
    neighbours = []
    (i - 1..i + 1).each do |i_inner|
      neighbouring_point = Point.new(i_inner, j)
      neighbours << neighbouring_point if neighbouring_point != point && valid_location?(neighbouring_point)
    end
    (j - 1..j + 1).each do |j_inner|
      neighbouring_point = Point.new(i, j_inner)
      neighbours << neighbouring_point if neighbouring_point != point && valid_location?(neighbouring_point)
    end
    neighbours
  end

  def get_neighbours(point)
    i = point.x
    j = point.y
    neighbours = []
    (i - 1..i + 1).each do |i_inner|
      (j - 1..j + 1).each do |j_inner|
        neighbouring_point = Point.new(i_inner, j_inner)
        neighbours << neighbouring_point if neighbouring_point != point && valid_location?(neighbouring_point)
      end
    end
    neighbours
  end

  def get_neighbour_values(point)
    get_neighbours(point).map { |n| value_at(n) }
  end

  def valleys
    v = []
    @grid.each_with_index do |y, j|
      y.each_with_index do |value, i|
        point = Point.new(i, j)
        neighbours = get_neighbour_values(Point.new(i, j))
        v << point unless neighbours.reject(&:nil?).any? { |n| n <= value }
      end
    end
    v
  end

  def to_s
    @grid.map { |g| g.join(" ") }.join("\n")
  end
end
