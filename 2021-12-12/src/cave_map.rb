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

    if visited.key?(cave.name)
      return if visited.values.select { |x| x == small_caves_count }.any?
      visited[cave.name] += 1
    elsif cave.small?
      visited[cave.name] = 1
    end

    @connections[cave.name].each do |c|
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
      unless @connections.include?(c.start.name)
        @connections[c.start.name] = []
      end
      unless @connections.include?(c.end.name)
        @connections[c.end.name] = []
      end
      @connections[c.start.name] << c.end unless c.end.start?
      @connections[c.end.name] << c.start unless c.end.end? || c.start.start?
    end
  end
end
