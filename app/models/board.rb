class Board
  EMPTY_CHAR = "."
  ROW_SEP = "\n`" + ("-" * 9) + "`\n"
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
      raise "Space taken"
    end
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
