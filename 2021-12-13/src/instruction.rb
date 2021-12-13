# frozen_string_literal: true

class Instruction
  attr_reader :axis, :position

  def initialize(instruction_string)
    if /fold along (?<axis>[xy])=(?<position>[0-9]+)/ =~ instruction_string
      @axis = axis.to_s
      @position = position.to_i
    end
  end

  def vertical?
    @axis == "x"
  end

  def horizontal?
    @axis == "y"
  end

  def to_s
    "fold along #{@axis}=#{@position}"
  end
end
