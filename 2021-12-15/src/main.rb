# frozen_string_literal: true

require "set"
require_relative "../../lib/read_file"
require_relative "./cavern"
require_relative "./chiton"

def part_1(cavern)
  # puts cavern
  # puts
  paths = cavern.paths
  puts cavern
  puts paths
end

def part_2(cavern)
  # puts cavern
  # puts
  # puts cavern
  paths = cavern.paths
  puts cavern
  puts paths
end

def parse_lines(input)
  input.map(&:strip).map do |line|
    line.chars.map(&:to_i).map { |risk_level| Chiton.new risk_level }
  end
end

def make_tiles(grid, x_times, y_times, x_length, y_length)
  increment = x_times + y_times
  (0..y_length - 1).each do |j|
    (0..x_length - 1).each do |i|
      # x_index = x_times * x_length + i
      y_index = y_times * y_length + j

      risk_level = grid[j][i].risk_level + increment

      grid.append([]) if y_index >= grid.length
      grid[y_index].append(Chiton.new(risk_level))
    end
  end
  grid
end

def parse_tiles(input, tiles)
  y_length = input.length
  x_length = input[0].strip.length
  grid = input.map(&:strip).map do |line|
    line.chars.map(&:to_i).map { |risk_level| Chiton.new risk_level }
  end
  tiles.times do |y_times|
    tiles.times do |x_times|
      next if y_times == 0 && x_times == 0
      grid = make_tiles(grid, x_times, y_times, x_length, y_length)
    end
  end
  grid
end

input_part_1 = read_file
part_1(Cavern.new(parse_lines(input_part_1)))
part_2(Cavern.new(parse_tiles(input_part_1, 5)))
