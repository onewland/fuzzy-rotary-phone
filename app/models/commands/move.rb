module Commands
  class Move < InGameCommand
    def execute
      return no_game_output unless get_match

      player_attempt_move = @ctx[:user_name]
      position = @ctx[:remaining_args][0].to_i

      begin
        @match.user_attempt_move(username: player_attempt_move, position: position)

        channel_output = "#{player_attempt_move} made their move.\n"
        channel_output << @match.board_inst.display
        channel_output << "\n"
        if @match.declaration
          channel_output << @match.declaration
        else
          channel_output << "It is now #{@match.current_user_name}'s turn\n"
        end

        ::CommandResponse.new(
          response_type: 'in_channel',
          text: channel_output
        )
      rescue Board::BoardSpaceTaken
        ::CommandResponse.new(
          text: 'That space is already taken.'
        )
      rescue Match::TurnOutOfOrder
        ::CommandResponse.new(
          text: 'Sorry, but it\'s not currently your turn.'
        )
      rescue Match::PlayerNotInMatch
        ::CommandResponse.new(
          text: 'You are not part of the current match in this channel.'
        )
      end
    end
  end
end
