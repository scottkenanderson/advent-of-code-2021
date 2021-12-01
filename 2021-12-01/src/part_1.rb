# frozen_string_literal: true

puts ARGV
filename = ARGV[0]

exit(1) unless filename

counter = 0
puts filename

lines = File.readlines(filename)
next_line = lines.shift

lines.each do |f|
  puts "old: #{next_line}"
  puts "new: #{f}"
  if f > next_line
    counter += 1
    puts "counter incremented"
  end
  next_line = f
end

puts "answer is #{counter}"