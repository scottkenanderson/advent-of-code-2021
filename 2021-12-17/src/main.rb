# frozen_string_literal: true

require "set"
require_relative "../../lib/read_file"
require_relative "./probe"
require_relative "./target_area"
require_relative "./trench"

# 17, 128

def part_1(target_area)
  puts target_area
  probe = Probe.new(target_area.max_point.x, target_area.min_point.y)
  points = [probe.point.clone]
  loop do
    probe.step
    points << probe.point.clone
    if target_area.contains(probe) || probe.point.y <= target_area.min_point.y || probe.point.x >= target_area.max_point.x
      break
    end
  end
  puts points.join(" ")
  trench = Trench.new(target_area, points)
  (target_area.min_point.y..target_area.max_point.y).each do |y|
    (target_area.min_point.x..target_area.max_point.x).each { |x| trench.mark(Point.new(x, y), "T") }
  end
  points.each { |p| trench.mark(p, "#") }
  trench.mark(Point.new(0, 0), "S")
  puts trench
  puts target_area.contains(probe)
  puts "max y: #{points.map(&:y).max}"
end

def part_2(target_area)
  puts target_area
  # probe = Probe.new(8, 1)
  # points = [probe.point.clone]
  puts target_area.max_point.x
  num = 0
  within_target_area = []
  (target_area.min_point.y..target_area.min_point.y.abs).each do |y|
    (0..target_area.max_point.x).each do |x|
      num += 1
      probe = Probe.new(x, y)
      loop do
        probe.step
        # points << probe.point.clone
        if target_area.contains(probe)
          within_target_area << probe
          break
        end
        if probe.point.y <= target_area.min_point.y + 1 || probe.point.x >= target_area.max_point.x + 1
          break
        end
      end

      # puts [x, y, target_area.contains(probe)].join(",")
    end
  end

  puts within_target_area.map(&:initial_speed).join(" ")
  puts within_target_area.length
  puts num
  # loop do
  #   probe.step
  #   puts probe
  #   points << probe.point.clone
  #   if target_area.contains(probe) || probe.point.y <= target_area.min_point.y || probe.point.x >= target_area.max_point.x
  #     break
  #   end
  # end
  # puts points.join(" ")
  # trench = Trench.new(target_area, points)
  # (target_area.min_point.y..target_area.max_point.y).each do |y|
  #   (target_area.min_point.x..target_area.max_point.x).each { |x| trench.mark(Point.new(x, y), "T") }
  # end
  # points.each { |p| trench.mark(p, "#") }
  # trench.mark(Point.new(0, 0), "S")
  # puts trench
  # puts target_area.contains(probe)
  # puts "max y: #{points.map(&:y).max}"
end

def parse_target_area(input)
  line = input.shift
  matched_line = /target area: x=(?<x_min>-?\d+)\.\.(?<x_max>-?\d+), y=(?<y_min>-?\d+)\.\.(?<y_max>-?\d+)/.match(line)

  captures = matched_line.named_captures
  TargetArea.new(captures["x_min"], captures["x_max"], captures["y_min"], captures["y_max"])
end

puts read_file
target_area = parse_target_area(read_file)

part_1(target_area)
part_2(target_area)
