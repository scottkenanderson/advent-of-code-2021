class Grid
  def initialize(initial_grid)
    @grid = initial_grid
  end

  def valid_location?(point)
    point.x >= 0 && point.y >= 0 && point.x < @grid[0].length && point.y < @grid.length
  end

  def x_length
    @grid[0].length
  end

  def y_length
    @grid.length
  end

  def retrieve(point)
    @grid[point.y][point.x]
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

  def to_s
    @grid.map { |y| y.map(&:to_s).join(" ") }.join("\n")
  end
end
