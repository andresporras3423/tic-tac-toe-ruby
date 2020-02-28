class Match
  attr_reader :board, :game_continue
  attr_accessor :turn, :players, :movements
  def initialize()
    @players = []
    @game_continue = true
    @turn = 0
    @board = [[' 1 ', '|', ' 2 ', '|', ' 3 '], ['---', '|', '---', '|', '---'], [' 4 ', '|', ' 5 ', '|', ' 6 '], ['---', '|', '---', '|', '---'], [' 7 ', '|', ' 8 ', '|', ' 9 ']]
    @movements = %w[1 2 3 4 5 6 7 8 9]
  end

  def add_players(player1, player2)
    @player = []
    if player1 != player2 && player1!='' && player2 != ''
      @players = [Player.new(player1, 'x'), Player.new(player2, '0')]
      puts "Welcome #{player1} and #{player2}"
    else
      puts "Please choose valid names"
    end
  end

  def update_after_move(movement)
    movement = movement.to_i
    if movements[movement - 1].nil? || movement <= 0
      puts 'please choose a valid spot'
    elsif movements[movement - 1] == '0' || movements[movement - 1] == 'x'
      puts 'not available spot'
    else
      movements[movement - 1] = players[turn % 2].symbol
      update_board
      find_winner(movement)
      @turn += 1
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

  def continue_conditions
    return true if game_continue && turn < 9
    return false
  end

  def draw_condition
    return unless turn == 9 && game_continue

    show_board
    puts 'Game was a draw'
  end


  def play_new_game(play_again)
    if play_again == '1'
      puts "great! let's play again"
      return 1
    elsif play_again == '2'
      puts "thank you for playing with us"
      return 2
    else
      puts 'choose a valid option'
      return 0
    end
  end
end
