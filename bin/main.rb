#!/usr/bin/env ruby
puts 'Hello World!'

puts 'enter name of player 1:'
player1 = gets.chomp
puts 'enter name of player 2:'
player2 = gets.chomp
i=0
puts 'show tic tac toe board'
loop do
  puts "#{(i%2==0 ? player1 : player2)} choose move: "
  move = gets.chomp
  puts 'updated board'
  i+=1
  if i>=5 # is impossible to have winner before the fifth movement
    puts "run method to see if current player has won the game"
  end
  if i==9 # on this point the board has not any movement available
    puts "board is full, game can't continue"
    break
  end
end
