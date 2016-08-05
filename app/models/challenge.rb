class Challenge
  class ChallengeNotFound < StandardError; end
  def self.create(channel:, x_player:, o_player:)
    Match.challenge(channel: channel, x_player: x_player, o_player: o_player)
  end

  def self.accept_challenge(channel:, o_player:)
    match = Match.where(channel: channel, status: 'challenge_open').first
    raise ChallengeNotFound unless match
    match.accept_challenge(o_player)
  end

  def self.challenge_params(params)
    {
      channel: params[:channel_name],
      x_player: params[:user_name],
      o_player: params[:remaining_args].strip.delete('@')
    }
  end
end
