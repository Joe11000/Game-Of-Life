#!/usr/bin/env ruby
require_relative '../lib/life'

CHARS = [" "] + %w[💜]

def print_frame(frame)
  print "\033[;f" # put the cursor in the upper left corner
  puts(frame.map do |row|
    row.map do |cell|
      CHARS[[cell, CHARS.size].min]
    end.join " "
  end.join("\n"))
end

frame = 20.times.map do
  20.times.map do
    [0,1].sample
  end
end

print "\033[2J" # clear terminal
loop do
  print_frame(frame)
  frame = Ecosystem.new(frame).tick
  sleep 1/10.0
end
