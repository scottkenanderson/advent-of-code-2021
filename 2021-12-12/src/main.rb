# frozen_string_literal: true

require "set"
require_relative "../../lib/read_file"
require_relative "./cave_map"
require_relative "./connection"

def part_1(cave_map)
  puts cave_map.paths
end

def part_2(cave_map)
  puts cave_map.paths(2)
end

def parse_connections(input)
  input.map(&:strip).map { |connection| Connection.new connection }
end

input = read_file
connections = parse_connections(input)

puts connections.join("\n")

part_1(CaveMap.new(connections))
part_2(CaveMap.new(connections))
