# frozen_string_literal: true

require_relative("./grid")
require_relative("./coordinate")
require_relative("./line")
require_relative("../../lib/read_file")

def calculate_overlap(lines, grid)
  lines.each do |line|
    line.points_between.each do |point|
      grid.mark(point)
    end
  end
  puts grid.grid.flatten.select { |s| s > 1 }.length
end

def part_1(lines, grid)
  calculate_overlap(lines.select(&:horizontal_or_vertical?), grid)
end

def part_2(lines, grid)
  calculate_overlap(lines, grid)
end

def parse_lines(input)
  max_x = 0
  max_y = 0
  lines = []
  input.each do |line|
    start_coords_raw, end_coords_raw = line.split(" -> ")
    start_coords = Coordinate.new(*start_coords_raw.split(","))
    end_coords = Coordinate.new(*end_coords_raw.split(","))
    lines << Line.new(start_coords, end_coords)
    max_x = [max_x, start_coords.x, end_coords.x].max
    max_y = [max_y, start_coords.y, end_coords.y].max
  end

  [lines, max_x, max_y]
end

input_part_1 = read_file
lines, max_x, max_y = parse_lines(input_part_1)

grid = Grid.new(max_x, max_y)
part_1(lines, grid)

grid = Grid.new(max_x, max_y)
part_2(lines, grid)
