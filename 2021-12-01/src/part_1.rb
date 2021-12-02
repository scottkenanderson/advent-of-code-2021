# frozen_string_literal: true

lines = read_file.map!(&:to_i)

next_line = lines.shift

puts "#{next_line} (N/A)"

counter = 0

lines.each do |line|
  if line > next_line
    counter += 1
    puts "#{line} (increased)"
  else
    puts "#{line} (decreased)"
  end
  next_line = line
end

puts "answer is #{counter}"
