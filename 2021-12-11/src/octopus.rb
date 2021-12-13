# frozen_string_literal: true

require "colorize"

class Octopus
  attr_accessor :energy_level, :highlighted

  def initialize(initial_energy_level)
    @energy_level = initial_energy_level
    @highlighted = false
    @last_step = 0
  end

  def step(step_number)
    if step_number != @last_step
      @last_step = step_number
      @highlighted = false
    end
    if @energy_level == 9
      highlight
      return true
    end
    @energy_level += 1 if @energy_level < 9 && !highlighted
    false
  end

  def highlight
    @energy_level = 0
    @highlighted = true
  end

  def to_s
    "\e[#{@highlighted ? 33 : 0}m#{@energy_level}\e[0m"
  end
end
