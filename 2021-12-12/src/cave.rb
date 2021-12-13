# frozen_string_literal: true

class Cave
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def small?
    @name =~ /[a-z]+/ && !start? && !end?
  end

  def big?
    @name =~ /[A-Z]+/
  end

  def start?
    @name == "start"
  end

  def end?
    @name == "end"
  end

  private def color
    return 33 if big?
    return 35 if start? || end?
    36
  end

  def hash
    name.hash
  end

  alias_method :eql?, :==

  def ==(other)
    self.class === other and
      other.name == @name
  end

  def to_s
    "\e[#{color}m#{name}\e[0m"
  end
end
