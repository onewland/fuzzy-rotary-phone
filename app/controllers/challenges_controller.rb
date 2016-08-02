class ChallengesController < ApplicationController
  def create
    challenge = Challenge.create(Challenge.challenge_params(params))
    if challenge.errors.empty?
      render json: {
        response_type: "in_channel"
        text: "@#{challenge.o_player}, @#{challenge.x_player} has challenged you to a game.
               To accept, run /ttt-accept"
      }
    else
      render json: { text: challenge.errors.full_messages.join("\n") }
    end
  end

  def accept
  end
end
