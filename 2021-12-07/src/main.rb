# frozen_string_literal: true

require_relative("./swarm")
require_relative("../../lib/read_file")

def part1(swarm)
  puts "Initial state:\t\t#{swarm}"
  output = (swarm.min..swarm.max).map { |i| swarm.calculate_linear_fuel(i) }
  # output.each_with_index { |x, i| puts "Position\t#{i}:\t#{x}" }
  puts "Part 1:\t\t#{output.each_with_index.min}"
end

def part2(swarm)
  output = (swarm.min..swarm.max).map { |i| swarm.calculate_summation_fuel(i) }
  # output.each_with_index { |x, i| puts "Position\t#{i}:\t#{x}" }
  puts "Part 2:\t\t#{output.each_with_index.min}"
end

def parse_initial_state(input)
  Swarm.new.tap do |s|
    s.initial_values(
      input[0]
        .split(",")
        .map(&:strip)
        .map(&:to_i)
    )
  end
end

input_part1 = read_file
swarm = parse_initial_state(input_part1)
part1(swarm)
part2(swarm)
