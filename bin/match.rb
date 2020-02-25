class Match
  attr_accessor :players, :turn, :board, :game_continue, :movements
  def initialize(players)
    @players = players
    @game_continue = true
    @turn = 0
    @board = [[' 1 ', '|', ' 2 ', '|', ' 3 '], ['---', '|', '---', '|', '---'], [' 4 ', '|', ' 5 ', '|', ' 6 '], ['---', '|', '---', '|', '---'], [' 7 ', '|', ' 8 ', '|', ' 9 ']]
    @movements = %w[1 2 3 4 5 6 7 8 9]
  end


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

  def find_winner(move)
    n1 = (move / 3).ceil * 3
    n2 = (move - 1) % 3
    line = players[turn % 2].symbol + players[turn % 2].symbol + players[turn % 2].symbol
    if (movements[n1 - 1] + movements[n1 - 2] + movements[n1 - 3] == line) || (movements[n2] + movements[n2 + 3] + movements[n2 + 6] == line) || (movements[0] + movements[4] + movements[8] == line) || (movements[2] + movements[4] + movements[6] == line)
      show_board
      puts players[turn % 2].name + ' is the winner'
      @game_continue = false
    end
  end
end