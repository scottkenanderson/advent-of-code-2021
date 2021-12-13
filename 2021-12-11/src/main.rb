# frozen_string_literal: true

require "set"
require_relative "../../lib/read_file"
require_relative "./cavern"
require_relative "./octopus"

def part_1(cavern)
  puts "Before any steps"
  puts cavern
  (1..100).each do |i|
    puts "\n--------------\n"
    puts "After step #{i}"
    cavern.step(i)
    puts cavern
  end

  puts "There have been #{cavern.flash_count} flashes"
end

def part_2(cavern)
  puts "Part 2"
  puts cavern
  step_number = 1
  until cavern.step(step_number)
    step_number += 1
  end
  puts "All flashed at: #{step_number}"
end

def parse_lines(input)
  input.map(&:strip).map do |line|
    line.chars.map(&:to_i).map { |energy_level| Octopus.new energy_level }
  end
end

input_part_1 = read_file

part_1(Cavern.new(parse_lines(input_part_1)))
part_2(Cavern.new(parse_lines(input_part_1)))
