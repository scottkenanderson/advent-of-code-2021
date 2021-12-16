# frozen_string_literal: true

require "colorize"

class Chiton
  attr_accessor :risk_level, :min_distance

  def initialize(risk_level)
    @risk_level = risk_level < 10 ? risk_level : (risk_level % 10) + 1
    @highlighted = false
    @min_distance = nil
  end

  def set_min_distance(min_distance)
    old_distance = @min_distance
    @min_distance = @min_distance.nil? ? min_distance : [min_distance, @min_distance].min
    old_distance == @min_distance
  end

  def highlight
    @highlighted = true
  end

  def reset_highlight
    @highlighted = false
  end

  def to_s
    # "\e[#{@highlighted ? 33 : 0}m#{@risk_level}\e[0m"
    # "\e[#{@highlighted ? 33 : 0}m#{@risk_level}: #{@min_distance}\e[0m"
    "#{@risk_level}: #{@min_distance}"
    # "\e[#{@highlighted ? 33 : 0}m#{@min_distance}\e[0m"
  end
end
