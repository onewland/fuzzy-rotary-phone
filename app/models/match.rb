class Match < ActiveRecord::Base
  validates_presence_of :channel, :x_player, :o_player

  validate :only_open_match_or_challenge_in_channel?

  def self.challenge(channel:, x_player:, o_player:)
    Match.create(channel: channel,
                 x_player: x_player,
                 o_player: o_player,
                 status: 'challenge_open')
  end

  def accept_challenge(o_player)
    if self.o_player == o_player && status == 'challenge_open'
      self.status = 'game_in_progress'
      self.accepted_at = Time.now
      self.board = "........."
      save
      return self
    else
      errors.add(:o_player, :not_challenged, "#{o_player} was not challenged to a match")
    end
  end

  def only_open_match_or_challenge_in_channel?
    matches = Match.where(channel: channel, status: ['game_in_progress','challenge_open']).load
    unless matches.count == 0 || (id == matches.first.id)
      errors[:base] << "channel #{channel} has outstanding challenge or match"
    end
  end

  def board_inst
    @board_inst ||= Board.from_descriptor(self.board)
  end
end
