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

  def get_h_v_neighbours(point)
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

  def get_down_right_neighbours(point)
    i = point.x
    j = point.y
    neighbours = []
    neighbouring_point = Point.new(i, j + 1)
    neighbours << neighbouring_point if valid_location?(neighbouring_point)
    neighbouring_point = Point.new(i + 1, j)
    neighbours << neighbouring_point if valid_location?(neighbouring_point)
    neighbours
  end

  def get_up_down_right_neighbours(point)
    i = point.x
    j = point.y
    neighbours = get_down_right_neighbours(point)
    neighbouring_point = Point.new(i, j - 1)
    neighbours << neighbouring_point if valid_location?(neighbouring_point)
    neighbours
  end

  def get_up_left_neighbours(point)
    i = point.x
    j = point.y
    neighbours = []
    neighbouring_point = Point.new(i, j - 1)
    neighbours << neighbouring_point if valid_location?(neighbouring_point)
    neighbouring_point = Point.new(i - 1, j)
    neighbours << neighbouring_point if valid_location?(neighbouring_point)
    neighbours
  end

  def get_up_left_down_neighbours(point)
    i = point.x
    j = point.y
    neighbours = get_up_left_neighbours(point)
    neighbouring_point = Point.new(i, j + 1)
    neighbours << neighbouring_point if valid_location?(neighbouring_point)
    neighbours
  end

  def to_s
    @grid.map { |y| y.map(&:to_s).join("\t") }.join("\n")
  end
end
