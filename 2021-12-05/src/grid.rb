class Grid
  attr_accessor :grid

  def initialize(max_x, max_y)
    @grid = []
    i = 0
    while i <= max_y
      j = 0
      inner = []
      while j <= max_x
        inner << 0
        j += 1
      end
      @grid << inner
      i += 1
    end
  end

  def mark(coordinate)
    @grid[coordinate.y][coordinate.x] += 1
  end

  def to_s
    @grid.each do |row|
      puts row.join("\t")
    end
  end
end
