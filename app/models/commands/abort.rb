module Commands
  class Abort < Command
    def execute
      @match = Match.where(
        status: ['game_in_progress','challenge_open'],
        channel: @ctx[:channel_name]
      ).first
      @match.abort_game
      ::CommandResponse.new(text: "ended game/challenge of #{@match.x_player} vs. #{@match.o_player}")
    end
  end
end
