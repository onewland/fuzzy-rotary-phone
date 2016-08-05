module Commands
  class ShowBoard < InGameCommand
    def execute
      return no_game_output unless get_match

      channel_output = "It is currently #{@match.current_user_name}'s turn\n"
      channel_output << @match.board_inst.display

      ::CommandResponse.new(
        response_type: 'in_channel',
        text: channel_output
      )
    end
  end
end
