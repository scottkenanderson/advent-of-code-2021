# frozen_string_literal: true

require_relative("./display")
require_relative("../../lib/read_file")

def part_1(displays)
  unique_segments = displays.map(&:unique_segments_count).sum
  puts "Part 1:\t#{unique_segments}"
end

def part_2(displays)
  sum_of_outputs = displays.map(&:part2).map(&:to_i).sum
  puts "Part 2:\t#{sum_of_outputs}"
end

def parse_displays(input)
  input.map { |line| Display.new(*line.split("|")) }
end

input_part_1 = read_file
displays = parse_displays(input_part_1)
puts displays.map(&:to_values).join("\n")
puts "-------"
puts displays.join("\n")
puts "-------"
puts displays.map(&:to_sorted_s).join("\n")
puts "-------"
puts displays.map(&:part2).join("\n")
puts "-------"

part_1(displays)
part_2(displays)

# grid = Grid.new(max_x, max_y)
# part_2(lines, grid)
# displays = parse_displays(input)
