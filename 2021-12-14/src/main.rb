# frozen_string_literal: true

require "set"
require_relative "../../lib/read_file"
require_relative "./polymer"

def part_1(polymer_template, pair_insertion_rules)
  polymer = Polymer.new polymer_template, pair_insertion_rules
  10.times do |i|
    polymer.step_efficient
    puts "#{i + 1}: #{polymer.length}"
  end
  puts polymer
  puts (polymer.most_common - polymer.least_common).to_s
end

def part_2(polymer_template, pair_insertion_rules)
  polymer = Polymer.new polymer_template, pair_insertion_rules
  40.times do |i|
    polymer.step_efficient
    puts "#{i + 1}: #{polymer.length}"
  end
  puts polymer
  puts (polymer.most_common - polymer.least_common).to_s
end

def parse_input(input)
  pair_insertion_rules = {}
  polymer_template = input.shift.strip
  input.map(&:strip).each do |line|
    if /(?<elements>[A-Z]{2}) -> (?<insertion>[A-Z])/ =~ line
      pair_insertion_rules[elements] = insertion
    end
  end

  [polymer_template, pair_insertion_rules]
end

input = read_file
polymer_template, pair_insertion_rules = parse_input(input)

puts polymer_template
puts pair_insertion_rules

part_1(polymer_template, pair_insertion_rules)
part_2(polymer_template, pair_insertion_rules)
