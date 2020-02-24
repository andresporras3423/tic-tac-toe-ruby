#!/usr/bin/env ruby
puts 'Hello World!'

puts 'enter name of player 1:'
player1 = gets.chomp
puts 'enter name of player 2:'
player2 = gets.chomp
loop do
  puts 'show tic tac toe board'
  puts "#{player1} choose move"
  move = gets.chomp
  puts 'updated board'
  puts "#{player2} choose move"
  move = gets.chomp
end
