# require_relative 'sliding_pieces.rb'
# require_relative 'stepping_pieces.rb'
require 'byebug'

class Piece
  attr_reader :color, :symbol, :current_pos, :moves

  def initialize(current_pos, board, color)
    @current_pos = current_pos
    @board = board
    @color = color
    @moves = []
  end

  def to_s
    return "#{@symbol}"
  end

  def current_pos=(position)
    @board[current_pos] = NullPiece.instance unless current_pos.nil?
    @board[position] = self
    @current_pos = position
  end

  def make_move(cur_pos, move)
    cur_x, cur_y = cur_pos
    dx, dy = move
    return [cur_x + dx, cur_y + dy]
  end

  def move_into_check?(new_pos)

    dummy_board = @board.dup_board

    # dummy_self = dummy_board[@current_pos]

    # dummy_self.current_pos = new_pos
    dummy_board.move_piece(self.current_pos, new_pos)

    dummy_board.in_check?(self.color)
  end


  module SteppingPiece
    def valid_moves
      pos = @current_pos
      moves = self.class::MOVES
      moves.each do |move|
        new_pos = make_move(pos, move)
          if valid_move?(new_pos)
            @moves << new_pos
          end
      end
      @moves
    end

    def valid_move?(space)
      x,y = space
      if x.between?(0,7) && y.between?(0,7) && !move_into_check?(space)
        if @board[space].class == NullPiece || @board[space].color != @color
          return true
        else
          return false
        end
      end
    end
  end

  module SlidingPiece
    def valid_moves
      pos = @current_pos
      moves =  self.class::MOVES

        moves.each do |move|
          new_pos = make_move(pos, move)
          if valid_move?(new_pos)
             while valid_move?(new_pos)
              @moves << new_pos
             new_pos = make_move(new_pos, move)
             end
          end
        end
        @moves
    end

    def valid_move?(space)
      x,y = space
      if x.between?(0,7) && y.between?(0,7) && !move_into_check?(space)
        if @board[space].class == NullPiece || @board[space].color != @color
          return true
        end
      else
        return false
      end
    end

  end

end

class Bishop < Piece
include SlidingPiece

 MOVES = [[1,1], [-1,-1],[-1,1],[1,-1]]

 def initialize(current_pos, board, color)
   @symbol = :B
   super
 end

end

class Rook < Piece
  include SlidingPiece

  MOVES = [[0,1], [0, -1], [1, 0], [-1, 0]]

  def initialize(current_pos, board, color)
    @symbol = :R
    super
  end

end

class Queen < Piece
  include SlidingPiece

  MOVES = [[0,1], [0, -1], [1, 0], [-1, 0],
      [1,1], [-1,-1],[-1,1],[1,-1]]

    def initialize(current_pos, board, color)
      super
      @symbol = :Q
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
  def initialize(current_pos, board, color)
    @symbol = :Kn
    super
  end

end

class King < Piece

  include SteppingPiece

  def initialize(current_pos, board, color)
    @symbol = :K
    super
  end

  MOVES = [[1, 1],[1, -1],[1,  0],[-1, 1],[-1, -1],[-1, 0],[0,  1],[0, -1]]
end


class Pawn < Piece

  def initialize(current_pos, board, color)
    @symbol = :P
    super
  end


  def valid_moves
    direction = [1,0]
    new_pos = make_move(@current_pos,direction)
    @moves << new_pos if @board[new_pos].class == NullPiece

    diagonal = [[1,1], [1,-1]]
    diagonal.each do |diag|
      new_pos = make_move(@current_pos, diag)
      if @board[new_pos].class != NullPiece && new_pos[1].between?(0,7)
        @moves << new_pos if @board[new_pos].color != @color
      end
    end
    @moves
  end

end
