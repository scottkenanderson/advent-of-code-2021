class ValueNode < Node
  attr_accessor :value, :parent
  def initialize(value, parent = nil)
    @value = value.to_i
    @parent = parent
  end

  def magnitude
    @value
  end

  # def +(other)
  #   @value + other.value
  # end

  def to_s
    @value.to_s
  end
end
