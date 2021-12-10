# frozen_string_literal: true

require "set"
require_relative "../../lib/read_file"

def closing_tags
  {
    "(" => ")",
    "[" => "]",
    "<" => ">",
    "{" => "}"
  }
end

def parse_illegal_lines(line)
  stack = []
  # puts line
  scores = {
    ")" => 3,
    "]" => 57,
    ">" => 25137,
    "}" => 1197
  }
  line.each_char do |char|
    # puts "#{closing_tags}\t\"#{char}\"\t#{closing_tags[char]}"
    if closing_tags.include?(char)
      stack << char
      # puts "#{char}\tpushing #{char}:\t\t#{stack.join(" ")}"
    else
      opening_tag = stack.pop
      if char == closing_tags[opening_tag]
        # puts "#{char}\tpopping #{opening_tag}, #{char}:\t#{stack.join(" ")}"
      else
        # puts "#{char}\texpected #{closing_tags[opening_tag]}, but found #{char} instead: #{scores[char]}"
        return scores[char]
      end
    end
  end
  # puts stack
  # puts "got to the end, #{stack.length}"
  0
end

def parse_incomplete_lines(line)
  stack = []
  # puts line
  scores = {
    ")" => 1,
    "]" => 2,
    "}" => 3,
    ">" => 4
  }
  line.each_char do |char|
    if closing_tags.include?(char)
      stack << char
    else
      opening_tag = stack.pop
      unless char == closing_tags[opening_tag]
        return scores[char]
      end
    end
  end

  autocomplete = stack.reverse.map { |c| closing_tags[c] }
  score = 0
  autocomplete.each do |c|
    score *= 5
    score += scores[c]
  end
  score
end

def part_1(lines)
  values = lines.map { |line| parse_illegal_lines(line) }
  puts values.sum
end

def part_2(lines)
  incomplete_lines = []
  lines.map { |line| parse_illegal_lines(line) }.each_with_index do |s, i|
    incomplete_lines << lines[i] if s.zero?
  end
  scores = incomplete_lines.map { |line| parse_incomplete_lines(line) }.sort
  puts scores[scores.length / 2]
end

def parse_lines(input)
  input.map(&:strip)
end

input_part_1 = read_file
lines = parse_lines(input_part_1)

part_1(lines)
part_2(lines)
