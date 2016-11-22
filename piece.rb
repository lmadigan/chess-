# require_relative 'sliding_pieces.rb'
# require_relative 'stepping_pieces.rb'
require_relative 'null_piece.rb'

class Piece
  attr_reader :color, :symbol, :current_pos

  def initialize(current_pos, board, color, symbol)
    @current_pos = current_pos
    @board = board
    @color = color
    @symbol = symbol
    @moves = []
    end

  def to_s
    return "Piece"
  end





  module SteppingPiece

    def self.valid_moves(pos)
      valid_moves = []

      cur_x, cur_y = pos
      MOVES.each do |(dx, dy)|
        new_pos = [cur_x + dx, cur_y + dy]

        if new_pos.all? { |coord| coord.between?(0, 7) }
          valid_moves << new_pos
        end
      end

      @moves = valid_moves
    end

  end



  module SlidingPiece

    def self.valid_moves(pos)
        MOVES.each do |move|
          new_pos = make_move(pos, move)
          while valid_move?(new_pos)
          @moves << new_pos
          new_pos = make_move(new_pos, move)
          end
        end
      @moves = valid_moves
    end

    def make_move(pos, move)
        cur_x, cur_y = pos
        (dx, dy) = move
        return [cur_x + dx, cur_y + dy]
    end

    def valid_move?(space)
      if @board[space] == NullPiece && space.between?(0, 7)
        return false if @board[space].color == @color
      else
        return true
      end
    end
  end
end

class Bishop < Piece
include SlidingPiece

 MOVES = [[1,1], [-1,-1],[-1,1],[1,-1]]

 def initialize
   @symbol = :B
   super(current_pos, board, color)
 end

end

class Rook < Piece
  include SlidingPiece

  DIRECTIONS = [[0,1], [0, -1], [1, 0], [-1, 0]]

  def initialize
    @symbol = :R
    super(current_pos, board, color)
  end

end

class Queen < Piece
  include SlidingPiece

  MOVES = [[0,1], [0, -1], [1, 0], [-1, 0],
      [1,1], [-1,-1],[-1,1],[1,-1]]

    def initialize
      @symbol = :Q
      super(current_pos, board, color)
    end
end


class Knight < Piece
  include SteppingPiece

  MOVES = [
    [-2, -1],
    [-2,  1],
    [-1, -2],
    [-1,  2],
    [ 1, -2],
    [ 1,  2],
    [ 2, -1],
    [ 2,  1]
  ]
  def initialize
    @symbol = :Kn
    super(current_pos, board, color)
  end

end

class King < Piece
  include SteppingPiece

  def initialize
    @symbol = :K
    super(current_pos, board, color)
  end

  MOVES = [[1, 1],
    [1, -1],
    [1,  0],
    [-1, 1],
    [-1, -1],
    [-1, 0],
    [0,  1],
    [0, -1]]
end


class Pawn < Piece
  include SteppingPiece

  def initialize
    @symbol = :P
    super(current_pos, board, color)
  end

  MOVES = [[1, 0]]

end

class NullPiece
  attr_reader :color, :symbol

  def initialize
  end

  module Singleton
  end

  def to_s
    return "Null"
  end
end
