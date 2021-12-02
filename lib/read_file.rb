# frozen_string_literal: true

def read_file
  filename = ARGV.shift || fail("please provide filename")
  File.readlines(filename)
end
