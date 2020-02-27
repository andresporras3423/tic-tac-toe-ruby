require_relative '../bin/match'
require_relative '../bin/player'

RSpec.describe Match do
  it 'Test game 1, Oscar wins in the seventh movement' do
    match = Match.new([Player.new('Oscar', 'x'), Player.new('Ángel', '0')])
    expect do
      match.show_board
    end.to output(" 1 | 2 | 3 \n---|---|---\n 4 | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
    expect(match.game_continue).to eql(true)
    match.movements[0] = 'x'
    match.update_board
    expect do
      match.find_winner(1)
    end.to output("").to_stdout
    expect(match.game_continue).to eql(true)
    match.turn += 1
    expect do
      match.show_board
    end.to output(" x | 2 | 3 \n---|---|---\n 4 | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
    match.movements[1] = '0'
    match.update_board
    expect do
      match.find_winner(2)
    end.to output("").to_stdout
    expect(match.game_continue).to eql(true)
    match.turn += 1
    expect do
      match.show_board
    end.to output(" x | 0 | 3 \n---|---|---\n 4 | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
    match.movements[2] = 'x'
    match.update_board
    expect do
      match.find_winner(3)
    end.to output("").to_stdout
    expect(match.game_continue).to eql(true)
    match.turn += 1
    expect do
      match.show_board
    end.to output(" x | 0 | x \n---|---|---\n 4 | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
    match.movements[3] = '0'
    match.update_board
    expect do
      match.find_winner(4)
    end.to output("").to_stdout
    expect(match.game_continue).to eql(true)
    match.turn += 1
    expect do
      match.show_board
    end.to output(" x | 0 | x \n---|---|---\n 0 | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
    match.movements[4] = 'x'
    match.update_board
    expect do
      match.find_winner(5)
    end.to output("").to_stdout
    expect(match.game_continue).to eql(true)
    match.turn += 1
    expect do
      match.show_board
    end.to output(" x | 0 | x \n---|---|---\n 0 | x | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
    match.movements[5] = '0'
    match.update_board
    expect do
      match.find_winner(6)
    end.to output("").to_stdout
    expect(match.game_continue).to eql(true)
    match.turn += 1
    expect do
      match.show_board
    end.to output(" x | 0 | x \n---|---|---\n 0 | x | 0 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
    match.movements[6] = 'x'
    match.update_board
    expect do
      match.find_winner(7)
    end.to output(" x | 0 | x \n---|---|---\n 0 | x | 0 \n---|---|---\n x | 8 | 9 \nOscar is the winner\n").to_stdout
    expect(match.game_continue).to eql(false)
  end
end

# def hello_world()
#   puts 'hello world'
# end

# RSpec.describe 'hello_world' do
#   it 'prints hello world' do

#     expect do
#       hello_world
#     end.to output("hello world\n").to_stdout
#   end
# end