require_relative '../bin/match'
require_relative '../bin/player'

RSpec.describe Match do
  it 'testing add_player method where names are valid' do
    match = Match.new
    expect {match.add_players('Oscar', 'Ángel')}.to output("Welcome Oscar and Ángel\n").to_stdout
  end
  it 'testing add_player method when names are invalid' do
    match = Match.new
    expect {match.add_players('Oscar', 'Oscar')}.to output("Please choose valid names\n").to_stdout
  end
  it 'testing update_after_move when input -5 as move' do
    match = Match.new
    match.players = [Player.new('Oscar', 'x'), Player.new('Ángel', '0')]
    expect {match.update_after_move(-5)}.to output("please choose a valid spot\n").to_stdout
  end
  it 'testing update_after_move when input abc as move' do
    match = Match.new
    match.players = [Player.new('Oscar', 'x'), Player.new('Ángel', '0')]
    expect {match.update_after_move('abc')}.to output("please choose a valid spot\n").to_stdout
  end
  it 'testing update_after_move when input 11 as move' do
    match = Match.new
    match.players = [Player.new('Oscar', 'x'), Player.new('Ángel', '0')]
    expect {match.update_after_move(11)}.to output("please choose a valid spot\n").to_stdout
  end
  it 'testing update_after_move when move is valid and then in a not available spot' do
    match = Match.new
    match.players = [Player.new('Oscar', 'x'), Player.new('Ángel', '0')]
    match.movements[4] = 'x'
    expect { match.update_after_move(5)}.to output("not available spot\n").to_stdout
  end
  it 'testing show_board after valid movement' do
    match = Match.new
    match.players = [Player.new('Oscar', 'x'), Player.new('Ángel', '0')]
    match.movements = %w[x 0 x 4 5 6 7 8 9]
    match.update_board
    expect {match.show_board}.to output(" x | 0 | x \n---|---|---\n 4 | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
  end
  it 'testing update_board' do
    match = Match.new
    match.players = [Player.new('Oscar', 'x'), Player.new('Ángel', '0')]
    match.movements = %w[1 2 3 x 0 x 7 8 9]
    match.update_board
    expect(match.board).not_to eql([[' x ', '|', ' 2 ', '|', ' 3 '], ['---', '|', '---', '|', '---'], [' x ', '|', ' 0 ', '|', ' x '], ['---', '|', '---', '|', '---'], [' 7 ', '|', ' 8 ', '|', ' 9 ']])
    
  end
  it 'testing find_winner when there is no winner yet' do
    match = Match.new
    match.players = [Player.new('Oscar', 'x'), Player.new('Ángel', '0')]
    match.movements = %w[1 2 3 x 0 x 7 8 9]
    match.turn = 2
    expect{match.find_winner(6)}.to output("").to_stdout
  end
  it 'testing find_winner when a winner after first player connects three in a diagonal' do
    match = Match.new
    match.players = [Player.new('Oscar', 'x'), Player.new('Ángel', '0')]
    match.movements = %w[x 0 x 0 x 0 x 8 9]
    match.update_board
    match.turn = 6
    expect{match.find_winner(7)}.to output(" x | 0 | x \n---|---|---\n 0 | x | 0 \n---|---|---\n x | 8 | 9 \nOscar is the winner\n").to_stdout
  end
  it 'testing find_winner when a winner after first player connects three in the same column' do
    match = Match.new
    match.players = [Player.new('Oscar', 'x'), Player.new('Ángel', '0')]
    match.movements = %w[x 0 3 x 0 6 x 8 9]
    match.update_board
    match.turn = 4
    expect{match.find_winner(7)}.to output(" x | 0 | 3 \n---|---|---\n x | 0 | 6 \n---|---|---\n x | 8 | 9 \nOscar is the winner\n").to_stdout
  end
  it 'testing find_winner when a winner after second player connects three in the same row' do
    match = Match.new
    match.players = [Player.new('Oscar', 'x'), Player.new('Ángel', '0')]
    match.movements = %w[0 0 0 x x 6 x 8 9]
    match.update_board
    match.turn = 5
    expect{match.find_winner(3)}.to output(" 0 | 0 | 0 \n---|---|---\n x | x | 6 \n---|---|---\n x | 8 | 9 \nÁngel is the winner\n").to_stdout
  end
  it 'testing find_winner when a winner after 9 movements and no winner' do
    match = Match.new
    match.players = [Player.new('Oscar', 'x'), Player.new('Ángel', '0')]
    match.movements = %w[0 0 x x 0 0 x x 0]
    match.update_board
    match.turn = 8
    expect{match.find_winner(8)}.to output("").to_stdout
  end
  it 'testing winner_conditions when there is no winner yet' do
    match = Match.new
    match.players = [Player.new('Oscar', 'x'), Player.new('Ángel', '0')]
    match.movements = %w[1 2 3 x 0 x 7 8 9]
    match.turn = 2
    expect{match.winner_conditions(6, 2, 'xxx')}.to output("").to_stdout
  end
  it 'testing winner_conditions when a winner after first player connects three in a diagonal' do
    match = Match.new
    match.players = [Player.new('Oscar', 'x'), Player.new('Ángel', '0')]
    match.movements = %w[x 0 x 0 x 0 x 8 9]
    match.update_board
    match.turn = 6
    expect{match.winner_conditions(9, 0, 'xxx')}.to output(" x | 0 | x \n---|---|---\n 0 | x | 0 \n---|---|---\n x | 8 | 9 \nOscar is the winner\n").to_stdout
  end
  it 'testing winner_conditions when a winner after first player connects three in the same column' do
    match = Match.new
    match.players = [Player.new('Oscar', 'x'), Player.new('Ángel', '0')]
    match.movements = %w[x 0 3 x 0 6 x 8 9]
    match.update_board
    match.turn = 4
    expect{match.winner_conditions(9, 0, 'xxx')}.to output(" x | 0 | 3 \n---|---|---\n x | 0 | 6 \n---|---|---\n x | 8 | 9 \nOscar is the winner\n").to_stdout
  end
  it 'testing winner_conditions when a winner after second player connects three in the same row' do
    match = Match.new
    match.players = [Player.new('Oscar', 'x'), Player.new('Ángel', '0')]
    match.movements = %w[0 0 0 x x 6 x 8 9]
    match.update_board
    match.turn = 5
    expect{match.winner_conditions(3, 2, '000')}.to output(" 0 | 0 | 0 \n---|---|---\n x | x | 6 \n---|---|---\n x | 8 | 9 \nÁngel is the winner\n").to_stdout
  end
  it 'testing winner_conditions when a winner after 9 movements and no winner' do
    match = Match.new
    match.players = [Player.new('Oscar', 'x'), Player.new('Ángel', '0')]
    match.movements = %w[0 0 x x 0 0 x x 0]
    match.update_board
    match.turn = 8
    expect{match.winner_conditions(9, 1, 'xxx')}.to output("").to_stdout
  end
  it 'testing continue_conditions when game_continue is false and turn is less than 9' do
    match = Match.new
    match.players = [Player.new('Oscar', 'x'), Player.new('Ángel', '0')]
    match.turn = 1
    expect(match.continue_conditions).to eql(true)
  end
end

# RSpec.describe Match do
#   it 'Test game 1, Oscar wins in the seventh movement' do
#     match = Match.new([Player.new('Oscar', 'x'), Player.new('Ángel', '0')])
#     expect do
#       match.show_board
#     end.to output(" 1 | 2 | 3 \n---|---|---\n 4 | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
#     expect(match.game_continue).to eql(true)
#     match.movements[0] = 'x'
#     match.update_board
#     expect do
#       match.find_winner(1)
#     end.to output('').to_stdout
#     expect(match.game_continue).to eql(true)
#     match.turn += 1
#     expect do
#       match.show_board
#     end.to output(" x | 2 | 3 \n---|---|---\n 4 | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
#     match.movements[1] = '0'
#     match.update_board
#     expect do
#       match.find_winner(2)
#     end.to output('').to_stdout
#     expect(match.game_continue).to eql(true)
#     match.turn += 1
#     expect do
#       match.show_board
#     end.to output(" x | 0 | 3 \n---|---|---\n 4 | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
#     match.movements[2] = 'x'
#     match.update_board
#     expect do
#       match.find_winner(3)
#     end.to output('').to_stdout
#     expect(match.game_continue).to eql(true)
#     match.turn += 1
#     expect do
#       match.show_board
#     end.to output(" x | 0 | x \n---|---|---\n 4 | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
#     match.movements[3] = '0'
#     match.update_board
#     expect do
#       match.find_winner(4)
#     end.to output('').to_stdout
#     expect(match.game_continue).to eql(true)
#     match.turn += 1
#     expect do
#       match.show_board
#     end.to output(" x | 0 | x \n---|---|---\n 0 | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
#     match.movements[4] = 'x'
#     match.update_board
#     expect do
#       match.find_winner(5)
#     end.to output('').to_stdout
#     expect(match.game_continue).to eql(true)
#     match.turn += 1
#     expect do
#       match.show_board
#     end.to output(" x | 0 | x \n---|---|---\n 0 | x | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
#     match.movements[5] = '0'
#     match.update_board
#     expect do
#       match.find_winner(6)
#     end.to output('').to_stdout
#     expect(match.game_continue).to eql(true)
#     match.turn += 1
#     expect do
#       match.show_board
#     end.to output(" x | 0 | x \n---|---|---\n 0 | x | 0 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
#     match.movements[6] = 'x'
#     match.update_board
#     expect do
#       match.find_winner(7)
#     end.to output(" x | 0 | x \n---|---|---\n 0 | x | 0 \n---|---|---\n x | 8 | 9 \nOscar is the winner\n").to_stdout
#     expect(match.game_continue).to eql(false)
#   end

#   it 'Test game 2, Ángel wins in the sixth movement' do
#     match = Match.new([Player.new('Oscar', 'x'), Player.new('Ángel', '0')])
#     expect do
#       match.show_board
#     end.to output(" 1 | 2 | 3 \n---|---|---\n 4 | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
#     expect(match.game_continue).to eql(true)
#     match.movements[1] = 'x'
#     match.update_board
#     expect do
#       match.find_winner(2)
#     end.to output('').to_stdout
#     expect(match.game_continue).to eql(true)
#     match.turn += 1
#     expect do
#       match.show_board
#     end.to output(" 1 | x | 3 \n---|---|---\n 4 | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
#     match.movements[0] = '0'
#     match.update_board
#     expect do
#       match.find_winner(1)
#     end.to output('').to_stdout
#     expect(match.game_continue).to eql(true)
#     match.turn += 1
#     expect do
#       match.show_board
#     end.to output(" 0 | x | 3 \n---|---|---\n 4 | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
#     match.movements[4] = 'x'
#     match.update_board
#     expect do
#       match.find_winner(5)
#     end.to output('').to_stdout
#     expect(match.game_continue).to eql(true)
#     match.turn += 1
#     expect do
#       match.show_board
#     end.to output(" 0 | x | 3 \n---|---|---\n 4 | x | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
#     match.movements[3] = '0'
#     match.update_board
#     expect do
#       match.find_winner(4)
#     end.to output('').to_stdout
#     expect(match.game_continue).to eql(true)
#     match.turn += 1
#     expect do
#       match.show_board
#     end.to output(" 0 | x | 3 \n---|---|---\n 0 | x | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
#     match.movements[8] = 'x'
#     match.update_board
#     expect do
#       match.find_winner(9)
#     end.to output('').to_stdout
#     expect(match.game_continue).to eql(true)
#     match.turn += 1
#     expect do
#       match.show_board
#     end.to output(" 0 | x | 3 \n---|---|---\n 0 | x | 6 \n---|---|---\n 7 | 8 | x \n").to_stdout
#     match.movements[6] = '0'
#     match.update_board
#     expect do
#       match.find_winner(7)
#     end.to output(" 0 | x | 3 \n---|---|---\n 0 | x | 6 \n---|---|---\n 0 | 8 | x \nÁngel is the winner\n").to_stdout
#     expect(match.game_continue).to eql(false)
#   end

#   it 'Test game 3, Oscar wins in fifth movement' do
#     match = Match.new([Player.new('Ángel', 'x'), Player.new('Oscar', '0')])
#     expect do
#       match.show_board
#     end.to output(" 1 | 2 | 3 \n---|---|---\n 4 | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
#     expect(match.game_continue).to eql(true)
#     match.movements[3] = 'x'
#     match.update_board
#     expect do
#       match.find_winner(4)
#     end.to output('').to_stdout
#     expect(match.game_continue).to eql(true)
#     match.turn += 1
#     expect do
#       match.show_board
#     end.to output(" 1 | 2 | 3 \n---|---|---\n x | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
#     match.movements[0] = '0'
#     match.update_board
#     expect do
#       match.find_winner(1)
#     end.to output('').to_stdout
#     expect(match.game_continue).to eql(true)
#     match.turn += 1
#     expect do
#       match.show_board
#     end.to output(" 0 | 2 | 3 \n---|---|---\n x | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
#     match.movements[4] = 'x'
#     match.update_board
#     expect do
#       match.find_winner(5)
#     end.to output('').to_stdout
#     expect(match.game_continue).to eql(true)
#     match.turn += 1
#     expect do
#       match.show_board
#     end.to output(" 0 | 2 | 3 \n---|---|---\n x | x | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
#     match.movements[1] = '0'
#     match.update_board
#     expect do
#       match.find_winner(1)
#     end.to output('').to_stdout
#     expect(match.game_continue).to eql(true)
#     match.turn += 1
#     expect do
#       match.show_board
#     end.to output(" 0 | 0 | 3 \n---|---|---\n x | x | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
#     match.movements[5] = 'x'
#     match.update_board
#     expect do
#       match.find_winner(6)
#     end.to output(" 0 | 0 | 3 \n---|---|---\n x | x | x \n---|---|---\n 7 | 8 | 9 \nÁngel is the winner\n").to_stdout
#     expect(match.game_continue).to eql(false)
#   end

#   it 'Test game 4, Draw' do
#     match = Match.new([Player.new('Ángel', 'x'), Player.new('Oscar', '0')])
#     expect do
#       match.show_board
#     end.to output(" 1 | 2 | 3 \n---|---|---\n 4 | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
#     expect(match.game_continue).to eql(true)
#     match.movements[3] = 'x'
#     match.update_board
#     expect do
#       match.find_winner(4)
#     end.to output('').to_stdout
#     expect(match.game_continue).to eql(true)
#     match.turn += 1
#     expect do
#       match.show_board
#     end.to output(" 1 | 2 | 3 \n---|---|---\n x | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
#     match.movements[0] = '0'
#     match.update_board
#     expect do
#       match.find_winner(1)
#     end.to output('').to_stdout
#     expect(match.game_continue).to eql(true)
#     match.turn += 1
#     expect do
#       match.show_board
#     end.to output(" 0 | 2 | 3 \n---|---|---\n x | 5 | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
#     match.movements[4] = 'x'
#     match.update_board
#     expect do
#       match.find_winner(5)
#     end.to output('').to_stdout
#     expect(match.game_continue).to eql(true)
#     match.turn += 1
#     expect do
#       match.show_board
#     end.to output(" 0 | 2 | 3 \n---|---|---\n x | x | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
#     match.movements[1] = '0'
#     match.update_board
#     expect do
#       match.find_winner(1)
#     end.to output('').to_stdout
#     expect(match.game_continue).to eql(true)
#     match.turn += 1
#     expect do
#       match.show_board
#     end.to output(" 0 | 0 | 3 \n---|---|---\n x | x | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
#     match.movements[2] = 'x'
#     match.update_board
#     expect do
#       match.find_winner(3)
#     end.to output('').to_stdout
#     expect(match.game_continue).to eql(true)
#     match.turn += 1
#     expect do
#       match.show_board
#     end.to output(" 0 | 0 | x \n---|---|---\n x | x | 6 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
#     match.movements[5] = '0'
#     match.update_board
#     expect do
#       match.find_winner(6)
#     end.to output('').to_stdout
#     expect(match.game_continue).to eql(true)
#     match.turn += 1
#     expect do
#       match.show_board
#     end.to output(" 0 | 0 | x \n---|---|---\n x | x | 0 \n---|---|---\n 7 | 8 | 9 \n").to_stdout
#     match.movements[8] = 'x'
#     match.update_board
#     expect do
#       match.find_winner(9)
#     end.to output('').to_stdout
#     expect(match.game_continue).to eql(true)
#     match.turn += 1
#     expect do
#       match.show_board
#     end.to output(" 0 | 0 | x \n---|---|---\n x | x | 0 \n---|---|---\n 7 | 8 | x \n").to_stdout
#     match.movements[6] = '0'
#     match.update_board
#     expect do
#       match.find_winner(7)
#     end.to output('').to_stdout
#     expect(match.game_continue).to eql(true)
#     match.turn += 1
#     expect do
#       match.show_board
#     end.to output(" 0 | 0 | x \n---|---|---\n x | x | 0 \n---|---|---\n 0 | 8 | x \n").to_stdout
#     match.movements[7] = 'x'
#     match.update_board
#     expect do
#       match.find_winner(8)
#     end.to output('').to_stdout
#     expect(match.game_continue).to eql(true)
#     match.turn += 1
#     expect do
#       match.draw_condition
#     end.to output(" 0 | 0 | x \n---|---|---\n x | x | 0 \n---|---|---\n 0 | x | x \nGame was a draw\n").to_stdout
#   end
# end
