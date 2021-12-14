# frozen_string_literal: true

require "set"
require_relative "../../lib/read_file"
require_relative "./dot"
require_relative "./instruction"
require_relative "./dots"
require_relative "./transparent_paper"

def part_1(grid, dots, instructions)
  paper = TransparentPaper.new(grid)
  dots.each { |dot| paper.mark(dot) }
  paper.fold(instructions[0])

  puts "#{paper.count_dots} dots are visible"
end

def part_2(grid, dots, instructions)
  paper = TransparentPaper.new(grid)
  dots.each { |dot| paper.mark(dot) }
  instructions.each { |instruction| paper.fold(instruction) }

  puts paper
end

def parse_input(input)
  dots = Dots.new
  instructions = []
  input.map(&:strip).each do |line|
    dots.add_dot(Dot.new(*line.split(","))) if /[0-9]+,[0-9]+/.match?(line)
    instructions << Instruction.new(line) if /fold along/.match?(line)
  end

  [dots, instructions]
end

input = read_file
dots, instructions = parse_input(input)
grid = []
(0..dots.max_y).each do |y|
  grid << (1..dots.max_x).map { |_| "." }
end

part_1(grid, dots, instructions)
part_2(grid, dots, instructions)
