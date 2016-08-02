class BoardController < ApplicationController
  def show
    @match = Match.where(status: 'game_in_progress', channel: params[:channel_name]).first

    render json: {
      response_type: 'in_channel',
      text: @match.board_inst.display
    }
  end
end
