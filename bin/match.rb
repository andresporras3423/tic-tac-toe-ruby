class Match
  attr_accessor :players, :turn, :board, :game_continue, :movements
  def initialize(players)
    @players = players
    @game_continue = true
    @turn = 0
    @board = [[' 1 ', '|', ' 2 ', '|', ' 3 '], ['---', '|', '---', '|', '---'], [' 4 ', '|', ' 5 ', '|', ' 6 '], ['---', '|', '---', '|', '---'], [' 7 ', '|', ' 8 ', '|', ' 9 ']]
    @movements = %w[1 2 3 4 5 6 7 8 9]
  end

  # show the current state of the board
  def show_board
    i = 0
    while i < board.length
      j = 0
      while j < board[i].length
        print board[i][j]
        j += 1
      end
      print "\n"
      i += 1
    end
  end

  # change the board after a player turn
  def update_board
    n = 0
    board.each do |i|
      i.map do |j|
        if j[0] == ' '
          j[1] = movements[n].to_s
          n += 1
        end
      end
    end
  end

  # look if some diagonal or the row or the column of the last player movement provides a winner for the game
  def find_winner(move)
    condition1 = (move / 3).ceil * 3
    condition2 = (move - 1) % 3
    line = players[turn % 2].symbol + players[turn % 2].symbol + players[turn % 2].symbol
    winner_conditions(condition1, condition2, line)
  end

  # if some diagonal or the row or the colum has the same symbol three times then there is a winner
  def winner_conditions(condition1, condition2, line)
    row1 = (movements[condition1 - 1] + movements[condition1 - 2] + movements[condition1 - 3] == line)
    column1 = (movements[condition2] + movements[condition2 + 3] + movements[condition2 + 6] == line)
    diagonal1 = (movements[0] + movements[4] + movements[8] == line)
    diagonal2 = (movements[2] + movements[4] + movements[6] == line)
    return unless row1 or column1 or diagonal1 or diagonal2

    show_board
    puts players[turn % 2].name + ' is the winner'
    @game_continue = false
  end
end
