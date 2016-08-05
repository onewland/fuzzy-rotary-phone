module Help
  class Help < Command
    def execute
      help_text = %Q{
Hello from Tic-Tac-Toebot.

I accept the following commands:
/ttt help display this message

/ttt challenge [player name] -- challenges [player name] to a game
/ttt accept -- accept a challenge issued by another player
/ttt board -- see current board, whose turn it is
/ttt move [1-9] -- place your marker in squares 1 through 9, going
   left to right and top to bottom
   `1 | 2 | 3`
   `---------`
   `4 | 5 | 6`
   `---------`
   `7 | 8 | 9`

/ttt abort -- end a game or waiting challenge
}
    ::CommandResponse.new(help_text)
    end
  end
end
