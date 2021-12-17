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
    @type.to_i(2).to_s(16) == "4"
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

  def to_s
    "packet: V: #{version_number}\tType: #{@type}\nNumbers: #{@numbers.flatten.join.to_i(2)}"
  end
end
