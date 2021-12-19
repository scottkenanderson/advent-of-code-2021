class Point
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x.to_i
    @y = y.to_i
  end

  def to_s
    "#{@x},#{@y}"
  end

  def +(other)
    return nil unless instance_of?(other.class)
    @x += other.x
    @y += other.y
    self
  end

  def ==(other)
    self.class == other.class && @x == other.x && @y == other.y
  end

  alias_method :eql?, :==

  def hash
    @x.hash ^ @y.hash
  end
end
