# frozen_string_literal: true

class Packet
  attr_reader :version, :type, :numbers, :length_type, :sub_packets

  def initialize(version, type)
    @version = version.join
    @type = type.join
    @numbers = []
    @length_type = nil
    @sub_packets = []
  end

  def is_operator
    !is_literal_value
  end

  def is_literal_value
    calculate_type == "LITERAL"
  end

  def add_number(number)
    @numbers << number
  end

  def add_sub_packet(sub_packet)
    @sub_packets << sub_packet
  end

  def set_length_type(length_type)
    @length_type = length_type
  end

  def version_number
    @version.to_i(2)
  end

  def type_number
    @type.to_i(2)
  end

  def length_bits
    return 15 if @length_type == "0"
    return 11 if @length_type == "1"
  end

  attr_reader :character_count

  def most_common
    @character_count.values.max
  end

  def least_common
    @character_count.values.min
  end

  def length
    6 + (5 * @numbers.length)
  end

  def value
    return @numbers.join.to_i(2) if calculate_type == "LITERAL"
    if sub_packets.empty?
      return "no sub packets"
    end
    sub_packet_values = @sub_packets.map(&:value)
    case calculate_type
    when "LESS THAN"
      sub_packet_values[0] < sub_packet_values[1] ? 1 : 0
    when "GREATER THAN"
      sub_packet_values[0] > sub_packet_values[1] ? 1 : 0
    when "EQUAL TO"
      sub_packet_values[0] == sub_packet_values[1] ? 1 : 0
    when "SUM"
      sub_packet_values.sum
    when "PRODUCT"
      sub_packet_values.reduce(&:*)
    when "MINIMUM"
      sub_packet_values.min
    when "MAXIMUM"
      sub_packet_values.max
    else
      puts "unknown type: #{calculate_type}"
      "?? ?"
    end
  end

  def calculate_type
    return "SUM" if type_number == 0
    return "PRODUCT" if type_number == 1
    return "MINIMUM" if type_number == 2
    return "MAXIMUM" if type_number == 3
    return "LITERAL" if type_number == 4
    return "GREATER THAN" if type_number == 5
    return "LESS THAN" if type_number == 6
    return "EQUAL TO" if type_number == 7
  end

  def to_s
    "packet: V: #{version_number}\tType: #{type_number}, #{calculate_type}" \
    "\nNumbers: #{@numbers.flatten.join}: #{@numbers.flatten.join.to_i(2)}, Value: #{value}\n" \
    "subpackets: #{@sub_packets.join("\n")}"
  end
end
