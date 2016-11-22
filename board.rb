class InvalidMoveError < StandardError
  attr_accessor :msg
  def initialize(msg)
    @msg = msg
  end
end

class Board
attr_accessor :grid
  def initialize(size=8)
    @grid= Array.new(size){[]}
    @size = size
    self.fill_empty_board
  end

  def fill_empty_board
  @grid.each_with_index do |row, idx|
    if idx == 0 || idx == 1 || idx == 6 || idx == 7
      @size.times do
        row << King.new

        #Left off here
        
      end
    else
      @size.times do
        row << NullPiece.new()
      end
    end
  end
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
    elsif valid_move?(start_pos, end_pos)
      raise InvalidMoveError.new("Invalid Move!")
    else
      piece = self[start_pos]
      update_pos(end_pos, piece)
      self[start_pos] = NullPiece
    end

  end

  def update_pos(new_pos, piece)
    self[new_pos] = piece
  end

  def valid_move?(start_pos, end_pos)
  end


end
