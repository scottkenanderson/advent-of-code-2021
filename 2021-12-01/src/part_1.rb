# frozen_string_literal: true

filename = ARGV[0]

exit(1) unless filename

counter = 0

lines = File.readlines(filename).map!(&:to_i)
next_line = lines.shift
puts "#{next_line} (N/A)"

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
