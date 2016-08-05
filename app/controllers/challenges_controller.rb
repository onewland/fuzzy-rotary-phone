class ChallengesController < ApplicationController
  def create
    challenge = Challenge.create(Challenge.challenge_params(params))
    if challenge.errors.empty?
      render json: {
        response_type: "in_channel",
        text: "@#{challenge.o_player}, @#{challenge.x_player} has challenged you to a game.
               To accept, run /ttt-accept"
      }
    else
      render json: { text: challenge.errors.full_messages.join("\n") }
    end
  end

  def accept
    o_player = params[:user_name]
    channel = params[:channel_name]
    challenge = Challenge.accept_challenge(channel: channel, o_player: o_player)
    if challenge.errors.empty?
      render json: {
        response_type: "in_channel",
        text: "@#{challenge.o_player} has accepted @#{challenge.x_player}'s tic-tac-toe challenge."
      }
    elsif !challenge.present?
      raise "not implemented yet"
    else
      render json: { text: challenge.errors.full_messages.join("\n") }
    end
  end

  def abort_game
    @match = Match.where(
      status: ['game_in_progress','challenge_open'],
      channel: params[:channel_name]
    ).first
    @match.abort_game
    render json: { text: "ended game/challenge of #{@match.x_player} vs. #{@match.o_player}"}
  end
end
