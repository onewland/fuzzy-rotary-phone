class BoardController < ApplicationController
  before_filter :get_match

  def show
    channel_output = "It is currently #{@match.current_user_name}'s turn\n"
    channel_output << @match.board_inst.display

    render json: {
      response_type: 'in_channel',
      text: channel_output
    }
  end

  def move
    player_attempt_move = params[:user_name]
    position = params[:text].to_i

    @match.user_attempt_move(username: player_attempt_move, position: position)

    channel_output = "#{player_attempt_move} made their move.\n"
    channel_output << @match.board_inst.display
    channel_output = "It is now #{@match.current_user_name}'s turn\n"

    render json: {
      response_type: 'in_channel',
      text: channel_output
    }
  end

  def get_match
    @match = Match.where(
      status: 'game_in_progress',
      channel: params[:channel_name]
    ).first
  end
end
