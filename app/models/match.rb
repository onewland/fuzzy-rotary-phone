class Match < ActiveRecord::Base
  validates_presence_of :channel, :x_player, :o_player

  validate :only_open_match_or_challenge_in_channel

  def self.challenge(channel:, x_player:, o_player:)
    Match.create(channel: channel,
                 x_player: x_player,
                 o_player: o_player,
                 status: 'challenge_open')
  end

  def only_open_match_or_challenge_in_channel
    matches = Match.where(channel: channel, status: ['game_in_progress','challenge_open']).load
    unless matches.count == 0 || (id == matches.first.id)
      errors.add(:channel, "channel #{channel} has outstanding challenge or match")
    end
  end
end
