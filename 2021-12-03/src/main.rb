# frozen_string_literal: true

require_relative("../../lib/read_file")

input = read_file

def part_1(input)
  gamma_rate = ""

  num_characters = input[0].strip.length
  midpoint = (input.length / 2).round

  i = 0

  while i < num_characters
    input.sort_by! { |x| x[i].to_i }
    gamma_rate += input[midpoint][i]
    i += 1
  end

  epsilon_rate = gamma_rate.chars.map { |x| x == "1" ? "0" : "1" }.join

  puts "gamma rate is #{gamma_rate.to_i(2)}"
  puts "epsilon rate is #{epsilon_rate.to_i(2)}"

  puts "part 1: #{gamma_rate.to_i(2) * epsilon_rate.to_i(2)}"
end

def part_2(input)
end

part_1(input.clone)
part_2(input)
