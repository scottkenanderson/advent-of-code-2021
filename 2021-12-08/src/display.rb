require 'set'
require_relative './digit'

class Display
  attr_accessor :signal_pattern, :output_value

  def initialize(signal_pattern_str, output_value_str)
    @signal_pattern = parse_input(signal_pattern_str)
    @output_value = parse_input(output_value_str)
    @all_values = (@signal_pattern + @output_value)
    @mapping = {}
    map_values
    @inverted_mapping = @mapping.invert
  end

  def map_values
    @all_values.map(&:to_set).to_set.to_a.map { |x| x.to_a.join('') }.join(' ')
    [1, 4, 7, 8].each { |i| @mapping[i] = @all_values.map.select { |v| v.value == i }.first.to_set }
    calculate6_characters
    calculate5_characters
  end

  def calculate5_characters
    five_chars = @all_values.select { |v| v.length == 5 }.map(&:to_set).to_set.to_a
    @mapping[3] = five_chars.select { |v| @mapping[1].subset?(v) }.first
    five_chars = five_chars.reject { |v| v == @mapping[3] }
    @mapping[5] = five_chars.select { |v| v.subset?(@mapping[6]) }.first
    @mapping[2] = five_chars.reject { |v| v.subset?(@mapping[6]) }.first
  end

  def calculate6_characters
    six_chars = @all_values.select { |v| v.length == 6 }.map(&:to_set).to_set.to_a
    six_chars.each do |v|
      if @mapping[4].subset?(v)
        @mapping[9] = v
      elsif @mapping[7].subset?(v)
        @mapping[0] = v
      end
    end
    @mapping[6] = six_chars.reject { |v| v == @mapping[0] }.reject { |v| v == @mapping[9] }.first
  end

  def unique_segments_count
    @output_value.map(&:value).reject { |i| i == -1 }.count
  end

  def to_values
    "#{@signal_pattern.map(&:value).join(" ")} | #{@output_value.map(&:value).join(" ")}"
  end

  def part2
    @output_value.map { |v| v.convert(@inverted_mapping) }.join("")
  end

  def to_s
    "#{@signal_pattern.join(" ")} | #{@output_value.join(" ")}"
  end

  def to_sorted_s
    "#{@signal_pattern.map(&:to_sorted_s).join(" ")} | #{@output_value.map(&:to_sorted_s).join(" ")}"
  end

  private

  def parse_input(input)
    input.strip.split(/\s+/).map { |d| Digit.new(d) }
  end
end
