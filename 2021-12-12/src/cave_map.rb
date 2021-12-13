# frozen_string_literal: true

require_relative "../../lib/point"

class CaveMap
  def initialize(connections_list)
    @connections = {}
    make_connections(connections_list)
    @paths = []
  end

  def get_path_recursive cave, visited, path, small_caves_count
    path << cave
    if cave.end?
      @paths << path.join(",")
      return
    end

    if visited.key?(cave)
      return if visited.values.select { |x| x == small_caves_count }.any?
      visited[cave] += 1
    elsif cave.small?
      visited[cave] = 1
    end

    @connections[cave].each do |c|
      get_path_recursive(c, visited.clone, path.clone, small_caves_count).to_s
    end
  end

  def paths(small_caves_count = 1)
    get_path_recursive(Cave.new("start"), {}, [], small_caves_count)
    # puts @paths.to_a.sort!.join("\n")
    path_count = @paths.length
    @paths = []
    path_count
  end

  private def make_connections connections_list
    connections_list.each do |c|
      unless @connections.include?(c.start)
        @connections[c.start] = []
      end
      unless @connections.include?(c.end)
        @connections[c.end] = []
      end
      @connections[c.start] << c.end unless c.end.start?
      @connections[c.end] << c.start unless c.end.end? || c.start.start?
    end
  end
end
