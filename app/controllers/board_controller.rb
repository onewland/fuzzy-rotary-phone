class BoardController < ApplicationController
  def show
    @match = Match.where(status: 'game_in_progress', channel: params[:channel_name]).first

    channel_output = "It is currently #{@match.current_user_name}'s turn\n"
    channel_output << @match.board_inst.display

    render json: {
      response_type: 'in_channel',
      text: channel_output
    }
  end
end
