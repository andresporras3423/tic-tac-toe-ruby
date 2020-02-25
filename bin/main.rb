#!/usr/bin/env ruby

require './player'
require './match'

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
    @match = Math.new([Player.new(player1, 'x'), Player.new(player2, '0')])
    play_game
  end
end