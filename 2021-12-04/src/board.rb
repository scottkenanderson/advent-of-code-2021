# frozen_string_literal: true

class Number
  attr_accessor :value
  attr_accessor :checked

  def initialize(value)
    @value = value
    @checked = false
  end

  def check(num = nil)
    @checked = true if num.nil? || num == @value
  end

  def score
    return 0 if checked

    value
  end

  def to_s
    "#{@value}:\t[#{@checked ? "x" : " "}]"
  end
end

class Board
  attr_accessor :rows
  attr_accessor :is_solved

  def initialize(raw_numbers)
    rows = []
    until raw_numbers.empty?
      row = []
      line = raw_numbers.shift.split(" ")
      row << Number.new(line.shift.to_i) until line.empty?
      rows << row
    end
    @rows = rows
    @is_solved = false
  end

  def draw(num)
    rows.each do |row|
      row.each { |x| x.check(num) }
    end
  end

  def check(array)
    array.map { |row| row.all?(&:checked) }.any?
  end

  def solved?
    return is_solved if is_solved

    check(@rows) || check(@rows.transpose)
  end

  def score(num)
    num * rows.map { |row| row.map(&:score).sum }.sum
  end

  def to_s
    rows.each { |x| puts x.join("\t") }
  end
end

class Boards
  attr_accessor :last_num

  def initialize(boards_array)
    @first_solved_index = -1
    @last_solved_index = -1
    @boards_array = boards_array
  end

  def draw(num)
    @boards_array.each { |board| board.draw(num) }
    @last_num = num
    first_solved
    last_solved
  end

  def first_solved
    return @first_solved_index if @first_solved_index > -1

    @boards_array.each_with_index do |board, index|
      @first_solved_index = index if board.solved?
    end
    @first_solved_index
  end

  def last_solved
    return @last_solved_index if @last_solved_index > -1

    unsolved_boards = []

    @boards_array.each_with_index do |board, index|
      unsolved_boards << index unless board.solved?
    end

    if unsolved_boards.length > 1
      return -1
    end

    @last_solved_index = unsolved_boards.shift
    @last_solved_index
  end

  def all_solved?
    @boards_array.map(&:solved?).all?
  end

  def score(board_index)
    @boards_array[board_index].score(@last_num)
  end

  def to_s
    @boards_array.each { |board| puts board }
  end
end
