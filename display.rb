require 'colorize'
require_relative 'board.rb'
require_relative 'cursor.rb'

class Display
attr_accessor :cursor, :board, :cursor_pos
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  #  @cursor_pos = @cursor.cursor_pos
  end

  def render

    @board.grid.each do |row|
      row_string = ""
      row.each do |space|
        if space == @board[@cursor.cursor_pos]
          row_string << space.to_s.colorize(:color => :white, :background =>:light_blue) + "     "
        else
         row_string << space.to_s + "    "
       end
      end
      puts row_string
    end
  end

  


end
