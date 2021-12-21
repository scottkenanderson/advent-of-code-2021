class Node
  attr_accessor :left, :right, :parent
  def initialize(left = nil, right = nil)
    @left = left || nil
    @right = right || nil
    @parent = nil
  end

  def magnitude
    3 * @left.magnitude + 2 * @right.magnitude
  end

  def to_s
    "[#{@left || "x"},#{@right || "x"}]"
  end
end
