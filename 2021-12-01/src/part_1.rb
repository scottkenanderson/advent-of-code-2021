# frozen_string_literal: true

puts ARGV
filename = ARGV[0]

exit(1) unless filename

counter = 0
puts filename

lines = File.readlines(filename)
next_line = lines.shift.to_i
puts "#{next_line} (N/A)"

lines.each do |f|
  f_int = f.to_i
  if f_int > next_line
    counter += 1
    puts "#{f_int} (increased)"
  else
    puts "#{f_int} (decreased)"
  end
  next_line = f_int
end

puts "answer is #{counter}"
