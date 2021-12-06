class Line
  attr_accessor :start_coords
  attr_accessor :end_coords

  def initialize(start_coords, end_coords)
    @start_coords = start_coords
    @end_coords = end_coords
  end

  def points_between
    return points_between_h_or_v if horizontal_or_vertical?

    points_between_diagonal
  end

  def points_between_diagonal
    x = start_coords.x
    y = start_coords.y
    diff_x = end_coords.x - x
    diff_y = end_coords.y - y
    points = []
    end_x_param = diff_x.positive? ? end_coords.x + 1 : end_coords.x - 1
    end_y_param = diff_y.positive? ? end_coords.y + 1 : end_coords.y - 1
    while x != end_x_param
      while y != end_y_param
        points << Coordinate.new(x, y)
        x += diff_x.positive? ? 1 : -1
        y += diff_y.positive? ? 1 : -1
      end
    end
    points
  end

  def points_between_h_or_v
    points = []
    (start_x..end_x).each do |x|
      (start_y..end_y).each do |y|
        points << Coordinate.new(x, y)
      end
    end
    points
  end

  def start_x
    [start_coords.x, end_coords.x].min
    # start_coords.x
  end

  def start_y
    [start_coords.y, end_coords.y].min
    # start_coords.y
  end

  def end_x
    [start_coords.x, end_coords.x].max
    # end_coords.x
  end

  def end_y
    [start_coords.y, end_coords.y].max
    # end_coords.y
  end

  def horizontal_or_vertical?
    start_coords.x == end_coords.x || start_coords.y == end_coords.y
  end

  def to_s
    "#{start_coords}-#{end_coords};horizontal:#{horizontal_or_vertical?}"
  end
end
