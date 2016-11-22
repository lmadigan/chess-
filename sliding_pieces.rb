require_relative 'piece.rb'



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
