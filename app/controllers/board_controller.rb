class BoardController < ApplicationController
  before_filter :get_match

  def show
    if @match
      channel_output = "It is currently #{@match.current_user_name}'s turn\n"
      channel_output << @match.board_inst.display

      render json: {
        response_type: 'in_channel',
        text: channel_output
      }
    else
      render json: { response_type: 'in_channel', text: 'No game in progress' }
    end
  end

  def get_match
    @match = Match.where(
      status: 'game_in_progress',
      channel: params[:channel_name]
    ).first
  end
end
