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

  def move
    player_attempt_move = params[:user_name]
    position = params[:text].to_i

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

      render json: {
        response_type: 'in_channel',
        text: channel_output
      }
    rescue Board::BoardSpaceTaken
      render json: {
        text: 'That space is already taken.'
      }
    rescue Match::TurnOutOfOrder
      render json: {
        text: 'Sorry, but it\'s not currently your turn.'
      }
    rescue Match::PlayerNotInMatch
      render json: {
        text: 'You are not part of the current match in this channel.'
      }
    end
  end

  def get_match
    @match = Match.where(
      status: 'game_in_progress',
      channel: params[:channel_name]
    ).first
  end
end
