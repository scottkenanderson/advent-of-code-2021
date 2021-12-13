# frozen_string_literal: true

require_relative "./cave"

class Connection
  attr_reader :start, :end

  def initialize(connection_string)
    start_name, end_name = connection_string.strip.split("-")
    @start = Cave.new(start_name)
    @end = Cave.new(end_name)
  end

  def to_s
    "#{@start}-#{@end}"
  end
end
