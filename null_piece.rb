require 'singleton'
require_relative 'piece.rb'

class NullPiece < Piece

  include Singleton

    def initialize
      super([], nil, :none)
      @symbol = :N
    end


end
