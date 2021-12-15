# frozen_string_literal: true

class Polymer
  attr_reader :axis, :position

  def initialize(polymer_template, pair_insertion_rules)
    @polymer_template = polymer_template
    @pair_insertion_rules = pair_insertion_rules
    @polymer = {}
    @character_count = {}

    polymer_template.chars.each_with_index do |p, i|
      @character_count[p] = @character_count.key?(p) ? @character_count[p] += 1 : 1
      next unless i < polymer_template.length - 1
      pair = "#{p}#{polymer_template[i + 1]}"
      @polymer[pair] = @polymer.key?(pair) ? @polymer[pair] += 1 : 1
    end
  end

  def step
    new_polymer = []
    @polymer.each_with_index do |p, i|
      new_polymer << p
      new_polymer << @pair_insertion_rules["#{p}#{@polymer[i + 1]}"] if i < @polymer.length - 1
    end
    @polymer = new_polymer
  end

  def step_efficient
    new_polymer = {}
    @polymer.keys.each do |p|
      pair_insertions(p).each do |pair|
        new_polymer[pair] = 0 unless new_polymer.key?(pair)
        new_polymer[pair] += @polymer[p]
      end
    end
    @polymer = new_polymer
  end

  def pair_insertions(pair)
    reaction = @pair_insertion_rules[pair]
    @character_count[reaction] = \
      @character_count.key?(reaction) ? @character_count[reaction] += @polymer[pair] : @polymer[pair]
    first, second = pair.chars
    ["#{first}#{reaction}", "#{reaction}#{second}"]
  end

  attr_reader :character_count

  def most_common
    @character_count.values.max
  end

  def least_common
    @character_count.values.min
  end

  def length
    @character_count.values.sum
  end

  def to_s
    "polymer template: #{@polymer_template}\npolymer: #{@polymer}\n#{@pair_insertion_rules}"
  end
end
