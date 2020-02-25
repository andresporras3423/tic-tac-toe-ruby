#!/usr/bin/env ruby
require_relative 'player'
require_relative 'match'

class Game
  attr_accessor :match, :player1, :player2
  def initialize
    puts 'Enter name of player 1:'
    @player1 = gets.chomp
    puts 'Enter name of player 2:'
    @player2 = gets.chomp
    begin_game
  end

  def begin_game
    @match = Match.new([Player.new(player1, 'x'), Player.new(player2, '0')])
    play_game
  end

  def play_game
    play_turn while match.game_continue && match.turn < 9
    if match.turn == 9 && match.game_continue
      match.show_board
      puts 'Game was a draw'
    end
    new_game
  end

  def new_game
    play_again=''
    loop do
      puts 'do you want to play again?:'
      puts '1) Yes'
      puts '2) No'
      play_again = gets.chomp
      if play_again != '1' && play_again != '2'
        puts 'choose a valid option'
      else
        break
      end
    end
    if play_again=='1'
      begin_game
    else
      puts 'thank you for playing with us'
    end
  end

  def play_turn
    match.show_board
    puts match.players[match.turn % 2].name + ', choose your movement (use available numbers): '
    movement = gets.chomp.to_i
    if match.movements[movement - 1] == nil
      puts 'please choose a valid spot'
    elsif match.movements[movement - 1] == '0' || match.movements[movement - 1] == 'x'
      puts 'not available spot'
    else
      match.movements[movement - 1] = match.players[match.turn % 2].symbol
      match.update_board
      match.find_winner(movement)
      match.turn += 1
    end
  end
end

Game.new