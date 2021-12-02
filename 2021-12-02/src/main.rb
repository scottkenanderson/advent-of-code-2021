# frozen_string_literal: true

require_relative("../../lib/read_file")

input = read_file.map! do |line|
  direction, units = line.split(" ")
  [direction, units.to_i]
end

def calculate_position(list_add, list_subtract)
  list_add.sum - list_subtract.sum
end

def part_1(input)
  commands = {}
  commands.default = []

  input.each do |direction, units|
    commands[direction] = [] unless commands.key?(direction)
    commands[direction] << units.to_i
  end

  horizontal = calculate_position(commands['forward'], [])
  depth = calculate_position(commands['down'], commands['up'])

  puts "part 1: #{horizontal * depth}"
end

def part_2(input)
  horizontal = 0
  depth = 0
  aim = 0

  input.each do |direction, units|
    case direction
    when "forward"
      horizontal += units
      depth += units * aim
    when "down"
      aim += units
    when "up"
      aim -= units
    end
  end

  puts "part 2: #{horizontal * depth}"
end

part_1(input)
part_2(input)