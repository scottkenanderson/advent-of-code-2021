# frozen_string_literal: true

def read_file
  filename = ARGV[0] || fail("please provide filename")
  File.readlines(filename)
end
