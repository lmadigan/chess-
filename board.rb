class Board

  def initialize(size=8)
    @grid= Array.new(size){[]}
    @size = size
    self.fill_empty_board
  end

  def fill_empty_board
  @grid.each_with_index do |row, idx|
    if idx == 0 || idx == 1 || idx == 6 || idx == 7
      @size.times do
        row << Piece.new()
      end
    else
      @size.times do
        row << NullPiece.new()
      end
    end
  end
end
end

class Piece
end

class NullPiece
end
