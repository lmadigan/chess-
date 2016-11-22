require_relative 'piece.rb'


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
