class ChallengesController < ApplicationController
  def create
    Challenge.create(Challenge.challenge_params(params))
  end

  def accept
  end
end
