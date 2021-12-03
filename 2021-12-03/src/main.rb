# frozen_string_literal: true

require_relative("../../lib/read_file")

input = read_file

def common_character(list, char_index)
  midpoint = (list.length / 2).round
  sorted_list = list.sort_by { |x| x[char_index].to_i }

  return nil unless sorted_list[midpoint][char_index] == sorted_list[midpoint - 1][char_index]

  sorted_list[midpoint][char_index]
end

def most_common_character(list, char_index, tie_breaker = "")
  common_character(list, char_index) || tie_breaker
end

def least_common_character(list, char_index, tie_breaker = "")
  most_common_character_result = common_character(list, char_index)
  return tie_breaker if most_common_character_result.nil?

  invert(most_common_character_result)
end

def invert(character)
  character == "1" ? "0" : "1"
end

def part_1(input)
  gamma_rate = ""
  num_characters = input[0].strip.length
  i = 0

  while i < num_characters
    gamma_rate += most_common_character(input, i)
    i += 1
  end

  epsilon_rate = gamma_rate.chars.map { |x| invert(x) }.join

  puts "gamma rate is #{gamma_rate.to_i(2)}"
  puts "epsilon rate is #{epsilon_rate.to_i(2)}"

  puts "part 1: #{gamma_rate.to_i(2) * epsilon_rate.to_i(2)}"
end

def get_rating(input, fallback, func)
  num_characters = input[0].strip.length
  i = 0
  while i < num_characters
    break if input.length == 1

    most_common = method(func).call(input, i, fallback)
    input.select! { |x| x[i] == most_common }
    i += 1
  end

  input[0]
end

def part_2(input)
  oxygen_generator_rating = get_rating(input.clone, "1", :most_common_character)
  co2_scrubber_rating = get_rating(input.clone, "0", :least_common_character)

  puts "oxygen_generator_rating is #{oxygen_generator_rating.to_i(2)}"
  puts "co2_scrubber_rating is #{co2_scrubber_rating.to_i(2)}"

  puts "part 2: #{oxygen_generator_rating.to_i(2) * co2_scrubber_rating.to_i(2)}"
end

part_1(input.clone)
part_2(input.clone)
