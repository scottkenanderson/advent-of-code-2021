# frozen_string_literal: true

require "set"
require_relative "../../lib/read_file"
require_relative "./node"
require_relative "./value_node"

def explode_nodes(root, xparent = nil, level = 1)
  nodes = []
  stack = [root]
  until stack.empty?
    node = stack.pop
    if node.is_a? ValueNode
      next
    end
    level = 0
    node_parent = node
    loop do
      node_parent = node_parent.parent
      break if node_parent.nil?
      level += 1
    end
    nodes << node if level >= 4

    stack.push node.right unless node.right.nil?
    stack.push node.left unless node.left.nil?
  end

  return true if nodes.empty?

  leaf_nodes = []
  stack = [root]
  until stack.empty?
    node = stack.pop
    if node.is_a? ValueNode
      leaf_nodes << node
    else
      stack.push node.right unless node.right.nil?
      stack.push node.left unless node.left.nil?
    end
  end

  leaf_node_map = {}
  leaf_nodes.each_with_index { |n, i| leaf_node_map[n] = i }

  n = nodes.shift
  left_node_index = leaf_node_map[n.left] - 1
  leaf_nodes[left_node_index].value += n.left.value unless left_node_index.negative?
  right_node_index = leaf_node_map[n.right] + 1
  leaf_nodes[right_node_index].value += n.right.value unless right_node_index >= leaf_nodes.length
  new_node = ValueNode.new(0, n.parent)

  if n == n.parent.left
    n.parent.left = new_node
  elsif n == n.parent.right
    n.parent.right = new_node
  end

  nodes.empty?
end

def split_nodes(root, xparent = nil, level = 1)
  nodes = []
  stack = [root]
  until stack.empty?
    node = stack.pop
    if node.is_a? ValueNode
      nodes << node
    else
      stack.push node.right unless node.right.nil?
      stack.push node.left unless node.left.nil?
    end
  end
  node = nodes.find { |n| n.value >= 10 } # .join(" ")
  return false if node.nil?
  parent = node.parent

  new_node = Node.new
  new_node.parent = parent
  new_node.left = ValueNode.new((node.value / 2.0).floor, new_node)
  new_node.right = ValueNode.new((node.value / 2.0).ceil, new_node)

  if parent.left == node
    parent.left = new_node
  elsif parent.right == node
    parent.right = new_node
  end
  true
end

def set_parents(number)
  return if number.is_a? ValueNode
  number.left.parent = number
  set_parents(number.left)
  number.right.parent = number
  set_parents(number.right)
end

def part_1(numbers)
  numbers.each do |number|
    set_parents(number)
  end
  numbers.reduce do |number, i|
    node = Node.new(number, i)
    node.left.parent = node
    node.right.parent = node
    # puts "ADD----:\t#{node}"
    node_str = node.to_s
    new_node_str = ""
    loop do
      complete = explode_nodes(node, nil)
      set_parents(node)
      # puts "explode:\t#{node}"
      break if complete
    end
    loop do
      was_split = split_nodes(node, nil)
      # puts "split:\t\t#{node}"
      if was_split
        loop do
          complete = explode_nodes(node, nil)
          # puts "explode:\t#{node}"
          break if complete
        end
      end
      new_node_str = node.to_s
      # puts node_str, new_node_str
      if new_node_str == node_str
        break
      end
      node_str = new_node_str
      new_node_str = ""
      # exit
    end
    node
  end
end

def part_2(numbers)
  permutations = []
  numbers.map do |y|
    numbers.map do |x|
      permutations << [x, y] unless x == y
    end
  end
  permutations.map do |x, y|
    node = Node.new(parse_number(x), parse_number(y))
    node.left.parent = node
    node.right.parent = node
    set_parents(node)
    # puts "ADD----:\t#{node}"
    node_str = node.to_s
    new_node_str = ""
    loop do
      complete = explode_nodes(node, nil)
      set_parents(node)
      # puts "explode:\t#{node}"
      break if complete
    end
    loop do
      was_split = split_nodes(node, nil)
      # puts "split:\t\t#{node}"
      if was_split
        loop do
          complete = explode_nodes(node, nil)
          # puts "explode:\t#{node}"
          break if complete
        end
      end
      new_node_str = node.to_s
      # puts node_str, new_node_str
      if new_node_str == node_str
        break
      end
      node_str = new_node_str
      new_node_str = ""
    end
    node
  end.map(&:magnitude).max
end

def parse_number(line)
  stack = []
  line.chars.each do |c|
    node = Node.new
    if c == "["
      node = Node.new
      if stack.last
        if stack.last.left
          stack.last.right = node
        else
          stack.last.left = node
        end
      end
      stack << node
    end
    if c == "]"
      stack.pop if stack.length > 1
    end
    if /\d/.match?(c)
      x = stack.pop

      if x.left
        x.right = ValueNode.new(c.to_i)
      else
        x.left = ValueNode.new(c.to_i)
      end

      stack << x
    end
  end
  stack.first
end

def parse_lines(input)
  input.map(&:strip).map do |line|
    parse_number(line)
  end
end

input = read_file
# puts input.join("\n")
# numbers = parse_lines(input)
# puts numbers.join("\n")
puts part_1(parse_lines(input)).magnitude
puts part_2(input)

# part_2(Cavern.new(parse_tiles(input_part_1, 5)))
