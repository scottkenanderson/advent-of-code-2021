# frozen_string_literal: true

require_relative("./lanternfish")
require_relative("./school_optimized")
require_relative("../../lib/read_file")

def part_1(school, days)
  puts "Initial state:\t\t#{school}"
  (1..days).each do |i|
    school.pass_day
    puts "After\t#{i}\tdays:\t#{school}"
  end
  puts "Total fish:\t#{school.num_fish}"
end

def parse_initial_state(input)
  school = SchoolOptimized.new
  input[0].split(",").map do |timer|
    school.add_fish(Lanternfish.new(timer.to_i))
  end
  school
end

days = ARGV[1].to_i || fail("num days")

input_part_1 = read_file
school = parse_initial_state(input_part_1)
part_1(school, days)
