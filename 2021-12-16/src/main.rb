# frozen_string_literal: true

require "set"
require_relative "../../lib/read_file"
require_relative "./packet"

def get_all_sub_packets(all_packets, packet)
  all_packets << packet
  packet.sub_packets.each do |p|
    get_all_sub_packets(all_packets, p)
  end
end

def part_1(packet)
  all_packets = []
  get_all_sub_packets(all_packets, packet)
  puts ["sum of versions: ", all_packets.map(&:version_number).sum].join
end

def part_2(packet)
  puts ["packet value: ", packet.value].join
end

def parse_literal_value_packet(transmission_bits, packet)
  last_number = false
  until last_number
    last_number = transmission_bits.shift == "0"
    number = []
    4.times do
      number << transmission_bits.shift
    end
    # puts ["literal value packet number:", number.join, number.join.to_i(2)].join(" ")
    packet.add_number(number)
  end
  packet
end

def parse_operator_packet(transmission_bits, packet)
  packet.set_length_type(transmission_bits.shift)
  length = []
  packet.length_bits.times do
    length << transmission_bits.shift
  end
  if packet.length_bits == 11
    length.join.to_i(2).times do
      sub_packet = parse_header(transmission_bits)
      if sub_packet.is_literal_value
        parse_literal_value_packet(transmission_bits, sub_packet)
      else
        parse_operator_packet(transmission_bits, sub_packet)
      end
      packet.add_sub_packet(sub_packet)
    end
  end
  if packet.length_bits == 15
    sub_transmission = []
    length.join.to_i(2).times do
      sub_transmission << transmission_bits.shift
    end
    until sub_transmission.length == 0
      sub_packet = parse_header(sub_transmission)
      if sub_packet.is_literal_value
        parse_literal_value_packet(sub_transmission, sub_packet)
      else
        parse_operator_packet(sub_transmission, sub_packet)
      end
      packet.add_sub_packet(sub_packet)
    end
  end
end

def parse_header(transmission_bits)
  header = []
  2.times do
    field = []
    3.times do
      field << transmission_bits.shift
    end
    header << field
  end
  Packet.new(*header)
end

def parse_input(input)
  transmission = input.shift.strip
  puts transmission
  transmission_bits = transmission.hex.to_s(2).rjust(transmission.size * 4, "0").chars
  packet = parse_header(transmission_bits)

  if packet.is_literal_value
    parse_literal_value_packet(transmission_bits, packet)
  else
    parse_operator_packet(transmission_bits, packet)
  end
  packet
end

input = read_file
packet = parse_input(input)
part_1(packet)
part_2(packet)
