# frozen_string_literal: true

require_relative("./board")
require_relative("./number_drawer")
require_relative("../../lib/read_file")

def part_1(number_drawer, boards)
  boards.draw(number_drawer.draw) until boards.first_solved > -1
  puts boards.score(boards.first_solved)
end

def part_2(number_drawer, boards)
  boards.draw(number_drawer.draw) until boards.all_solved?
  puts boards.last_solved
  puts boards.score(boards.last_solved)
end

def parse_numbers(input)
  raw_numbers = input.shift
  input.shift
  number_array = raw_numbers.split(",").map(&:to_i)
  NumberDrawer.new(number_array)
end

def parse_boards(input)
  boards = []
  until input.empty?
    boards << Board.new(input.shift(5))
    input.shift
  end
  Boards.new(boards)
end

input_part_1 = read_file
number_drawer_1 = parse_numbers(input_part_1)
boards_1 = parse_boards(input_part_1)

input_part_2 = read_file
number_drawer_2 = parse_numbers(input_part_2)
boards_2 = parse_boards(input_part_2)

part_1(number_drawer_1, boards_1)
part_2(number_drawer_2, boards_2)
