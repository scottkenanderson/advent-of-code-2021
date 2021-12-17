# frozen_string_literal: true

require "set"
require_relative "../../lib/read_file"
require_relative "./packet"

def part_1
end

def part_2(polymer_template, pair_insertion_rules)
  polymer = Polymer.new polymer_template, pair_insertion_rules
  40.times do |i|
    polymer.step_efficient
    puts "#{i + 1}: #{polymer.length}"
  end
  puts polymer
  puts (polymer.most_common - polymer.least_common).to_s
end

def parse_literal_value_packet(transmission_bits, packet)
  last_number = false
  until last_number
    last_number = transmission_bits.shift == "0"
    number = []
    4.times do
      number << transmission_bits.shift
    end
    puts number.join
    packet.add_number(number)
  end

  packet
end

def parse_operator_packet(transmission_bits, packet)
  packet.set_length_type(transmission_bits.shift)
  puts [packet.length_bits, "length bits", packet.length_type]
  length = []
  packet.length_bits.times do
    length << transmission_bits.shift
  end
  puts packet
  puts "length"
  puts length.join.to_i(2)
  if packet.length_bits == 11
    length.join.to_i(2).times do
      sub_packet = parse_header(transmission_bits)
      if packet.is_literal_value
        puts "literally"
        parse_literal_value_packet(transmission_bits, packet)
      else
        parse_operator_packet(transmission_bits, packet)
      end
      packet.add_sub_packet(sub_packet)
      puts sub_packet.numbers
    end
  end
  if packet.length_bits == 15
    sub_transmission = []
    puts length.join.to_i(2)
    puts length.join.to_i(2)
    length.join.to_i(2).times do
      sub_transmission << transmission_bits.shift
    end
    puts sub_transmission.join
    until sub_transmission.length == 0
      sub_packet = parse_header(sub_transmission)
      if sub_packet.is_literal_value
        puts "literally"
        parse_literal_value_packet(sub_transmission, sub_packet)
      else
        parse_operator_packet(sub_transmission, sub_packet)
      end
      packet.add_sub_packet(sub_packet)
      puts "numbers", sub_packet.numbers
    end
  end
  puts "sub packet length", packet.sub_packets.length
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
  puts transmission_bits.length
  puts transmission_bits.join("")
  packet = parse_header(transmission_bits)

  puts [packet.version_number, packet.version, "version number"]

  if packet.is_literal_value
    puts "literally"
    parse_literal_value_packet(transmission_bits, packet)
  else
    parse_operator_packet(transmission_bits, packet)
  end
  puts packet

  # (4 - packet.length % 4).times do
  #   transmission_bits.shift
  # end
  # puts transmission_bits.length
  exit
end

input = read_file
polymer_template, pair_insertion_rules = parse_input(input)

puts polymer_template
puts pair_insertion_rules

part_1(polymer_template, pair_insertion_rules)
part_2(polymer_template, pair_insertion_rules)
