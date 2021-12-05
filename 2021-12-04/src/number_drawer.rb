class NumberDrawer
  def initialize(numbers)
    @numbers = numbers
  end

  def draw
    @numbers.shift unless @numbers.empty?
  end
end
