class Point
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x.to_i
    @y = y.to_i
  end

  def to_s
    "#{@x},#{@y}"
  end

  def ==(other)
    self.class == other.class && @x == other.x && @y == other.y
  end
end
