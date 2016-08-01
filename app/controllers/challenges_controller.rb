class ChallengesController < ApplicationController
  def create
    Rails.logger.info(Challenge.challenge_params(params))
    challenge = Challenge.create(Challenge.challenge_params(params))
    if challenge.errors.empty?
      render json: { text: "Successfully challenged #{challenge.o_player} to a game" }
    else
      render json: { text: challenge.errors.full_messages }
    end
  end

  def accept
  end
end
