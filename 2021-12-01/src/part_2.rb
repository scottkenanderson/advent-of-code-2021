# frozen_string_literal: true

filename = ARGV[0]

exit(1) unless filename

counter = 0

lines = File.readlines(filename).map!(&:to_i)
new_input = []

lines.each.with_index do |line, idx|
  new_input << (line + lines[idx + 1] + lines[idx + 2]) if (idx + 3) <= lines.length
end

next_line = new_input.shift

new_input.each do |line|
  if line > next_line
    counter += 1
    puts "#{line} (increased)"
  else
    puts "#{line} (decreased)"
  end
  next_line = line
end

puts "answer is #{counter}"
