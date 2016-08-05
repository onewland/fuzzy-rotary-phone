class Board
  class BoardSpaceTaken < StandardError; end
  
  EMPTY_CHAR = "."
  ROW_SEP = "\n`" + ("-" * 9) + "`\n"

  # if contents at any triplet of indices contains the same character, that
  # is a win condition
  WIN_CONDITIONS = [
    # rows
    [0,1,2],
    [3,4,5],
    [6,7,8],
    # columns
    [0,3,6],
    [1,4,7],
    [2,5,8],
    # diagonals
    [0,4,8],
    [2,4,6]
  ]


  attr_accessor :contents

  def initialize(contents)
    @contents = contents
  end

  def self.from_descriptor(str)
    Board.new(str.split(//))
  end

  def valid_move?(n)
    n >= 0 && n < 9 && contents[n] == EMPTY_CHAR
  end

  def apply_move(char, n)
    if valid_move?(n)
      contents[n] = char
      self
    else
      raise BoardSpaceTaken.new(n)
    end
  end

  def get_winner
    WIN_CONDITIONS.map do |triplet|
      triplet.map do |idx|
        contents[idx]
      end
    end.detect do |subset|
      subset[0] == subset[1] &&
      subset[1] == subset[2] && subset[0] != "."
    end.try(:first)
  end

  def to_match_board_repr
    contents.join("")
  end

  def display
    display_rows = []
    contents.each_slice(3) do |c_row|
      display_rows <<  c_row.map { |c| display_cell(c) }
    end
    display_rows.map { |r|
      "`" + r.join(" | ") + "`"
    }.join(ROW_SEP)
  end

  def display_cell(c)
    if c == EMPTY_CHAR
      " "
    else
      c
    end
  end
end
