# frozen_string_literal: true

require "forwardable"

class Dots
  include Enumerable
  extend Forwardable
  attr_reader :max_x, :max_y
  def_delegators :@dots, :each, :<<

  def initialize
    @dots = []
    @max_x = 0
    @max_y = 0
  end

  def add_dot(dot)
    @dots << dot
    @max_x = [@max_x, dot.x + 1].max
    @max_y = [@max_y, dot.y + 1].max
  end

  def to_s
    "x: #{@max_x}\ty: #{@max_y}\n#{@dots.join("\n")}"
  end
end
