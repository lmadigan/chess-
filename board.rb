require_relative 'null_piece.rb'
require_relative 'piece.rb'
require 'singleton'


class InvalidMoveError < StandardError
  attr_accessor :msg
  def initialize(msg)
    @msg = msg
  end
end

class Board
attr_accessor :grid, :king_white, :king_black, :size

  def initialize(grid=Array.new(8){[]})
    @grid= grid
    @size = 8
    @null = NullPiece.instance
  end

def play
  self.fill_empty_board
end

  def fill_empty_board
    8.times do |idx|
      @grid[1] << Pawn.new([1, idx], self, :black)
      @grid[6] << Pawn.new([6,idx], self, :white)
      @grid[2..5].each do |row|
        row << NullPiece.instance
      end
    end
    Rook.new(nil, self, :black).current_pos = [0,7]
    Rook.new(nil, self, :black).current_pos = [0,0]
    Rook.new(nil, self, :white).current_pos = [7,0]
    Rook.new(nil, self, :white).current_pos = [7,7]
    Knight.new(nil, self, :black).current_pos = [0,1]
    Knight.new(nil, self, :black).current_pos = [0,6]
    Knight.new(nil, self, :white).current_pos = [7,1]
    Knight.new(nil, self, :white).current_pos = [7,6]
    Bishop.new(nil, self, :black).current_pos = [0,2]
    Bishop.new(nil, self, :black).current_pos = [0,5]
    Bishop.new(nil, self, :white).current_pos = [7,2]
    Bishop.new(nil, self, :white).current_pos = [7,5]
    Queen.new(nil, self, :black).current_pos = [0,3]
    Queen.new(nil, self, :white).current_pos = [7,3]
  @king_black =  King.new(nil, self, :black)
  @king_black.current_pos = [0,4]
    @king_white = King.new(nil, self, :white)
    @king_white.current_pos = [7,4]
  end


  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, piece)
    row, col = pos
    @grid[row][col] = piece

  end

  def move_piece(start_pos, end_pos)

    if self[start_pos].class == NullPiece
      raise InvalidMoveError.new("No Piece There.")
    # elsif valid_move?(start_pos, end_pos)
    #   raise InvalidMoveError.new("Invalid Move!")
    else
      piece = self[start_pos]
      update_pos(end_pos, piece)
      self[start_pos] = NullPiece.instance
    end

  end

  def update_pos(new_pos, piece)
    self[new_pos] = piece
  end

  def valid_move?(start_pos, end_pos)

  end

  def in_check?(color)
    if color == :white
      king_pos = @king_white.current_pos
      opponent = :black
    else
      king_pos = @king_black.current_pos
      opponent = :white
    end
    potential = colors_moves(opponent)

    potential.include?(king_pos)

  end

  def colors_moves(color)
    all_moves_hash = {}
    all_moves = []
    @grid.each do |row|
      row.each do |col|
        if col.color == color
          all_moves_hash[col] = col.valid_moves
          col.valid_moves.each {|move| all_moves << move }
        end
      end
    end
    all_moves
  end

  def checkmate?(color)
      if color == :white
        king_moves = @king_white.valid_moves
        opponent = :black

      else
        king_moves = @king_black.valid_moves
        opponent = :white
      end
      potential = colors_moves(opponent)

      in_check?(color) && king_moves.all?{ |move| potential.include?(move) }
    end


    def dup_board
      d_board = Board.new()
      d_grid = d_board.grid
      grid.each_with_index do |row, x|
        row.each_with_index do |col, y|
          d_class = col.class
          d_color = col.color
          if d_class == NullPiece
            d_grid[x] << NullPiece.instance
          elsif d_class == King
            if d_color == :white
              d_board.king_white = d_class.new([x,y], d_board, d_color)
              d_grid[x] << d_board.king_white
            else
              d_board.king_black = d_class.new([x,y], d_board, d_color)
              d_grid[x] << d_board.king_black
            end
          else
            d_grid[x] << d_class.new([x,y], d_board, d_color)
          end
        end
      end
      d_board
    end


end
