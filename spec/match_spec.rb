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
    end.to output('').to_stdout
    expect(match.game_continue).to eql(true)
    match.turn += 1
    expect do
      match.show_board
    end.to output(" x | 2 | 3 \n---|---|---\n 4 | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
    match.movements[1] = '0'
    match.update_board
    expect do
      match.find_winner(2)
    end.to output('').to_stdout
    expect(match.game_continue).to eql(true)
    match.turn += 1
    expect do
      match.show_board
    end.to output(" x | 0 | 3 \n---|---|---\n 4 | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
    match.movements[2] = 'x'
    match.update_board
    expect do
      match.find_winner(3)
    end.to output('').to_stdout
    expect(match.game_continue).to eql(true)
    match.turn += 1
    expect do
      match.show_board
    end.to output(" x | 0 | x \n---|---|---\n 4 | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
    match.movements[3] = '0'
    match.update_board
    expect do
      match.find_winner(4)
    end.to output('').to_stdout
    expect(match.game_continue).to eql(true)
    match.turn += 1
    expect do
      match.show_board
    end.to output(" x | 0 | x \n---|---|---\n 0 | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
    match.movements[4] = 'x'
    match.update_board
    expect do
      match.find_winner(5)
    end.to output('').to_stdout
    expect(match.game_continue).to eql(true)
    match.turn += 1
    expect do
      match.show_board
    end.to output(" x | 0 | x \n---|---|---\n 0 | x | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
    match.movements[5] = '0'
    match.update_board
    expect do
      match.find_winner(6)
    end.to output('').to_stdout
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

  it 'Test game 2, Ángel wins in the sixth movement' do
    match = Match.new([Player.new('Oscar', 'x'), Player.new('Ángel', '0')])
    expect do
      match.show_board
    end.to output(" 1 | 2 | 3 \n---|---|---\n 4 | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
    expect(match.game_continue).to eql(true)
    match.movements[1] = 'x'
    match.update_board
    expect do
      match.find_winner(2)
    end.to output('').to_stdout
    expect(match.game_continue).to eql(true)
    match.turn += 1
    expect do
      match.show_board
    end.to output(" 1 | x | 3 \n---|---|---\n 4 | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
    match.movements[0] = '0'
    match.update_board
    expect do
      match.find_winner(1)
    end.to output('').to_stdout
    expect(match.game_continue).to eql(true)
    match.turn += 1
    expect do
      match.show_board
    end.to output(" 0 | x | 3 \n---|---|---\n 4 | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
    match.movements[4] = 'x'
    match.update_board
    expect do
      match.find_winner(5)
    end.to output('').to_stdout
    expect(match.game_continue).to eql(true)
    match.turn += 1
    expect do
      match.show_board
    end.to output(" 0 | x | 3 \n---|---|---\n 4 | x | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
    match.movements[3] = '0'
    match.update_board
    expect do
      match.find_winner(4)
    end.to output('').to_stdout
    expect(match.game_continue).to eql(true)
    match.turn += 1
    expect do
      match.show_board
    end.to output(" 0 | x | 3 \n---|---|---\n 0 | x | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
    match.movements[8] = 'x'
    match.update_board
    expect do
      match.find_winner(9)
    end.to output('').to_stdout
    expect(match.game_continue).to eql(true)
    match.turn += 1
    expect do
      match.show_board
    end.to output(" 0 | x | 3 \n---|---|---\n 0 | x | 6 \n---|---|---\n 7 | 8 | x \n").to_stdout
    match.movements[6] = '0'
    match.update_board
    expect do
      match.find_winner(7)
    end.to output(" 0 | x | 3 \n---|---|---\n 0 | x | 6 \n---|---|---\n 0 | 8 | x \nÁngel is the winner\n").to_stdout
    expect(match.game_continue).to eql(false)
  end

  it 'Test game 3, Oscar wins in fifth movement' do
    match = Match.new([Player.new('Ángel', 'x'), Player.new('Oscar', '0')])
    expect do
      match.show_board
    end.to output(" 1 | 2 | 3 \n---|---|---\n 4 | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
    expect(match.game_continue).to eql(true)
    match.movements[3] = 'x'
    match.update_board
    expect do
      match.find_winner(4)
    end.to output('').to_stdout
    expect(match.game_continue).to eql(true)
    match.turn += 1
    expect do
      match.show_board
    end.to output(" 1 | 2 | 3 \n---|---|---\n x | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
    match.movements[0] = '0'
    match.update_board
    expect do
      match.find_winner(1)
    end.to output('').to_stdout
    expect(match.game_continue).to eql(true)
    match.turn += 1
    expect do
      match.show_board
    end.to output(" 0 | 2 | 3 \n---|---|---\n x | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
    match.movements[4] = 'x'
    match.update_board
    expect do
      match.find_winner(5)
    end.to output('').to_stdout
    expect(match.game_continue).to eql(true)
    match.turn += 1
    expect do
      match.show_board
    end.to output(" 0 | 2 | 3 \n---|---|---\n x | x | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
    match.movements[1] = '0'
    match.update_board
    expect do
      match.find_winner(1)
    end.to output('').to_stdout
    expect(match.game_continue).to eql(true)
    match.turn += 1
    expect do
      match.show_board
    end.to output(" 0 | 0 | 3 \n---|---|---\n x | x | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
    match.movements[5] = 'x'
    match.update_board
    expect do
      match.find_winner(6)
    end.to output(" 0 | 0 | 3 \n---|---|---\n x | x | x \n---|---|---\n 7 | 8 | 9 \nÁngel is the winner\n").to_stdout
    expect(match.game_continue).to eql(false)
  end

  it 'Test game 4, Draw' do
    match = Match.new([Player.new('Ángel', 'x'), Player.new('Oscar', '0')])
    expect do
      match.show_board
    end.to output(" 1 | 2 | 3 \n---|---|---\n 4 | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
    expect(match.game_continue).to eql(true)
    match.movements[3] = 'x'
    match.update_board
    expect do
      match.find_winner(4)
    end.to output('').to_stdout
    expect(match.game_continue).to eql(true)
    match.turn += 1
    expect do
      match.show_board
    end.to output(" 1 | 2 | 3 \n---|---|---\n x | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
    match.movements[0] = '0'
    match.update_board
    expect do
      match.find_winner(1)
    end.to output('').to_stdout
    expect(match.game_continue).to eql(true)
    match.turn += 1
    expect do
      match.show_board
    end.to output(" 0 | 2 | 3 \n---|---|---\n x | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
    match.movements[4] = 'x'
    match.update_board
    expect do
      match.find_winner(5)
    end.to output('').to_stdout
    expect(match.game_continue).to eql(true)
    match.turn += 1
    expect do
      match.show_board
    end.to output(" 0 | 2 | 3 \n---|---|---\n x | x | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
    match.movements[1] = '0'
    match.update_board
    expect do
      match.find_winner(1)
    end.to output('').to_stdout
    expect(match.game_continue).to eql(true)
    match.turn += 1
    expect do
      match.show_board
    end.to output(" 0 | 0 | 3 \n---|---|---\n x | x | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
    match.movements[2] = 'x'
    match.update_board
    expect do
      match.find_winner(3)
    end.to output('').to_stdout
    expect(match.game_continue).to eql(true)
    match.turn += 1
    expect do
      match.show_board
    end.to output(" 0 | 0 | x \n---|---|---\n x | x | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
    match.movements[5] = '0'
    match.update_board
    expect do
      match.find_winner(6)
    end.to output('').to_stdout
    expect(match.game_continue).to eql(true)
    match.turn += 1
    expect do
      match.show_board
    end.to output(" 0 | 0 | x \n---|---|---\n x | x | 0 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
    match.movements[8] = 'x'
    match.update_board
    expect do
      match.find_winner(9)
    end.to output('').to_stdout
    expect(match.game_continue).to eql(true)
    match.turn += 1
    expect do
      match.show_board
    end.to output(" 0 | 0 | x \n---|---|---\n x | x | 0 \n---|---|---\n 7 | 8 | x \n").to_stdout
    match.movements[6] = '0'
    match.update_board
    expect do
      match.find_winner(7)
    end.to output('').to_stdout
    expect(match.game_continue).to eql(true)
    match.turn += 1
    expect do
      match.show_board
    end.to output(" 0 | 0 | x \n---|---|---\n x | x | 0 \n---|---|---\n 0 | 8 | x \n").to_stdout
    match.movements[7] = 'x'
    match.update_board
    expect do
      match.find_winner(8)
    end.to output('').to_stdout
    expect(match.game_continue).to eql(true)
    match.turn += 1
    expect do
      match.draw_condition
    end.to output(" 0 | 0 | x \n---|---|---\n x | x | 0 \n---|---|---\n 0 | x | x \nGame was a draw\n").to_stdout
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
