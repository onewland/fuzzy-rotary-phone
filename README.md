# fuzzy-rotary-phone
Tic-Tac-Toe Slack bot Integration

## Setup
Push to heroku.
Run `heroku run rake db:create db:migrate.`
Set ENV['SLACK_TTT_COMMAND_TOKEN'] to the token for your /-command
configuration.

## Usage as Slack user
`/ttt display` in-game help message

`/ttt challenge [player name]` -- challenges [player name] to a game

`/ttt accept` -- accept a challenge issued by another player

`/ttt board` -- see current board, whose turn it is

`/ttt move [1-9]` -- place your marker in squares 1 through 9, going
   left to right and top to bottom
   ```
   1 | 2 | 3
   ---------
   4 | 5 | 6
   ---------
   7 | 8 | 9
   ```

`/ttt abort` -- end a game or waiting challenge

## Schema
The table `matches` contains all match information.

Flow can be followed via the states (`status` column).
The state can be one of:
- challenge_open
- game_in_progress
- finished
- stalemate
- aborted

`/ttt challenge` creates a match in state challenge_open, if there is no match
with state challenge_open or game_in_progress in the current channel.

A match flows from challenge_open to either game_in_progress (if the challenge
is accepted with `/ttt accept`) or aborted (with `/ttt abort`).

Once a match reaches game_in_progress it can transition to finished, stalemate
or aborted depending on either the outcome of moves (`/ttt move`) or
`/ttt abort`.
