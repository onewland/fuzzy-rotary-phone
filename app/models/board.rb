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
