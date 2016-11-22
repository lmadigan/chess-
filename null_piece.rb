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
