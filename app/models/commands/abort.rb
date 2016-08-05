module Commands
  class Abort < Command
    def execute
      @match = Match.where(
        status: ['game_in_progress','challenge_open'],
        channel: @ctx[:channel_name]
      ).first
      
      if @match
        @match.abort_game
        ::CommandResponse.new(text: "Ended game/challenge of #{@match.x_player} vs. #{@match.o_player}")
      else
        ::CommandResponse.new(text: "No game in this channel to abort")
      end
    end
  end
end
