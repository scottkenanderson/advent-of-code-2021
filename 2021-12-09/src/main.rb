# frozen_string_literal: true

require "set"
require_relative "./heightmap"
require_relative "../../lib/read_file"

def part_1(heightmap)
  valleys = heightmap.valleys
  puts "Valleys: | #{valleys.join(" | ")} |"
  puts "Part 1:\t#{valleys.map { |p| heightmap.value_at(p) }.map { |v| v + 1 }.sum}"
end

def part_2(heightmap)
  basin_sizes = []
  valleys = heightmap.valleys

  valleys.each do |valley|
    stack = [valley]
    visited = Set.new
    until stack.empty?
      p = stack.pop
      next if visited.include?(p.to_s)

      visited.add(p.to_s)
      stack += heightmap.get_immediate_neighbours(p).reject { |v| heightmap.value_at(v) == 9 || visited.include?(v.to_s) }
      # puts "#{p}\t#{visited.length}\t| #{visited.to_a.join(' | ')} |"
    end
    # puts "Basin:\t\t| #{visited.to_a.join(" | ")} |"
    basin_sizes << visited.length
  end

  puts "Part 2:\t#{basin_sizes.sort!.reverse.slice(0, 3).reduce(:*)}"
end

def parse_heightmap(input)
  grid = input.map { |line| line.strip.split("").map(&:to_i) }
  Heightmap.new(grid)
end

input_part_1 = read_file
heightmap = parse_heightmap(input_part_1)

puts heightmap

part_1(heightmap)
part_2(heightmap)
