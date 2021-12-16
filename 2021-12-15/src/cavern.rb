# frozen_string_literal: true

require_relative "../../lib/point"
require_relative "../../lib/grid"

class Cavern < Grid
  attr_accessor :flash_count

  def initialize(initial_state)
    super(initial_state)
    retrieve(Point.new(0, 0)).set_min_distance(0)
  end

  def paths
    queue = [Point.new(0, 0)]
    path = []

    until queue.empty?
      point = queue.shift
      path << point
      get_up_down_right_neighbours(point).shuffle.sort_by { |p| retrieve(p).risk_level }.each do |c|
        # unless queue.include?(c)
        chiton = retrieve(c)
        chiton.highlight
        queue << c unless chiton.set_min_distance(get_up_left_down_neighbours(c).reject do |p|
          retrieve(p).min_distance.nil?
        end.map do |p|
          retrieve(p).min_distance
        end.min + chiton.risk_level)
        # end
      end
    end
    # puts path.join(" | ")
    ["min distance: ", retrieve(Point.new(x_length - 1, y_length - 1)).min_distance].join
  end
end
