# frozen_string_literal: true

require_relative "../../lib/point"
require_relative "../../lib/grid"

class Cavern < Grid
  attr_accessor :flash_count

  def initialize(initial_state)
    super(initial_state)
    @flash_count = 0
    @octopuses = 100
  end

  def flash_octopus(octopus, step_number, flashed, p)
    flash = octopus.step(step_number)
    if flash
      get_neighbours(Point.new(p.x, p.y)).each { |p| flashed.push p }
      @flash_count += 1
      @flashed_this_step += 1
    end
  end

  def step(step_number)
    @flashed_this_step = 0
    flashed = []
    @grid.each_with_index { |row, y|
      row.each_with_index { |octopus, x|
        flash_octopus(octopus, step_number, flashed, Point.new(x, y))
      }
    }
    until flashed.empty?
      p = flashed.pop
      flash_octopus(@grid[p.y][p.x], step_number, flashed, p)
    end

    @flashed_this_step == @octopuses
  end
end
