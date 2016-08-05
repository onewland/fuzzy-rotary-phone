class ChallengesController < ApplicationController
  def accept
    o_player = params[:user_name]
    channel = params[:channel_name]

    begin
      challenge = Challenge.accept_challenge(channel: channel, o_player: o_player)

      if challenge.errors.empty?
        channel_output = "#{challenge.o_player} has accepted #{challenge.x_player}'s challenge.\n"
        channel_output << "It is currently #{challenge.current_user_name}'s turn\n"
        channel_output << challenge.board_inst.display

        render json: {
          response_type: 'in_channel',
          text: channel_output
        }
      else
        render json: { text: challenge.errors.full_messages.join("\n") }
      end
    rescue Challenge::ChallengeNotFound
      render json: { text: "No challenge to accept in this channel." }
    end
  end
end
