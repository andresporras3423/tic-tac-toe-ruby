#!/usr/bin/env ruby
require_relative 'player'
require_relative 'match'

# control the flow of each tic tac toe match
class Game
  attr_reader :match, :player1, :player2
  def initialize
    @match = Match.new
    loop do
      puts 'Enter name of player 1:'
      @player1 = gets.chomp
      puts 'Enter name of player 2:'
      @player2 = gets.chomp
      match.add_players(@player1, @player2)
      break unless match.players == []
    end
    play_game
  end


  # keep playing while no winner and there is possible movements
  def play_game
    play_turn while match.continue_conditions
    match.draw_condition
    new_game
  end

  # ask the users if they want to play a new match
  def new_game
    play_again = ''
    loop do
      puts 'do you want to play again?:'
      puts '1) Yes'
      puts '2) No'
      play_again = gets.chomp
      play_again = match.play_new_game(play_again)
      if play_again == 1
        @match = Match.new
        match.add_players(player1, player2)
        play_game
        break
      elsif play_again == 2
        break
      end 
    end
  end

  # the current player choose his/her movement
  def play_turn
    match.show_board
    puts match.players[match.turn % 2].name + ', choose your movement (use available numbers): '
    movement = gets.chomp
    match.update_after_move(movement)
  end
end
# begin game
Game.new
