class InGameCommand < Command
  def get_match
    @match = Match.where(
      status: 'game_in_progress',
      channel: @ctx[:channel_name]
    ).first
  end

  def no_game_output
    ::CommandResponse.new(response_type: 'in_channel',
      text: 'No game in progress')
  end
end
