class Match < ActiveRecord::Base
  class PlayerNotInMatch < StandardError; end
  class TurnOutOfOrder < StandardError; end

  validates_presence_of :channel, :x_player, :o_player

  validate :only_open_match_or_challenge_in_channel?

  before_save :declare_winner, if: :game_in_progress?
  before_save :declare_stalemate, if: :game_in_progress?

  def declare_winner
    if win_char = board_inst.get_winner
      self.winner_char = win_char
      self.winner_username = user_name(win_char)
      self.status = 'finished'
      self.declaration = "#{winner_username} is the winner!"
    end
  end

  def declare_stalemate
    if !board_inst.get_winner && turns_taken_count == 9
      self.status = 'stalemate'
      self.declaration = "The game is a tie."
    end
  end

  def declaration
    @declaration
  end

  def declaration=(d)
    @declaration = d
  end

  def self.challenge(channel:, x_player:, o_player:)
    Match.create(channel: channel,
                 x_player: x_player,
                 o_player: o_player,
                 status: 'challenge_open')
  end

  def game_in_progress?
    status == 'game_in_progress'
  end

  def accept_challenge(o_player)
    if self.o_player == o_player && status == 'challenge_open'
      self.status = 'game_in_progress'
      self.accepted_at = Time.now
      self.board = "........."
      save
    else
      errors.add(:base, "#{o_player} was not challenged to a match")
    end
    return self
  end

  def user_attempt_move(username:, position:)
    char = '*'
    if x_player == username
      char = 'x'
    elsif o_player == username
      char = 'o'
    else
      raise PlayerNotInMatch.new(username)
    end

    apply_move(player: char, position: position)
  end

  def apply_move(player:, position:)
    position -= 1 # Assume 1-indexed player-given position
    with_lock do
      if current_turn == player
        self.board = board_inst.apply_move(player, position).to_match_board_repr
        @board_inst = Board.from_descriptor(self.board)
        self.current_turn = (player == 'x' ? 'o' : 'x')
        self.turns_taken_count += 1
        save!
      else
        raise TurnOutOfOrder.new(player)
      end
    end
  end

  def only_open_match_or_challenge_in_channel?
    matches = Match.where(
      channel: channel,
      status: ['game_in_progress','challenge_open']
    ).load

    unless matches.count == 0 || (id == matches.first.id)
      errors[:base] << "channel #{channel} has outstanding challenge or match"
    end
  end

  def abort_game
    self.status = 'aborted'
    save
  end

  def board_inst
    @board_inst ||= Board.from_descriptor(self.board)
  end

  def current_user_name
    user_name(current_turn)
  end

  def user_name(char)
    char == 'x' ? x_player : o_player
  end
end
