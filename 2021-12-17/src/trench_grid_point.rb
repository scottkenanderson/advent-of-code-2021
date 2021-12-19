class TrenchGridPoint
  attr_accessor :mark
  attr_writer :mark

  def initialize(mark)
    @mark = mark
  end

  def to_s
    @mark
  end
end
