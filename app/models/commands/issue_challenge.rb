module Commands
  class IssueChallenge < Command
    def execute
      challenge = Challenge.create(Challenge.challenge_params(@ctx))

      if challenge.errors.empty?
        ::CommandResponse.new(
          response_type: "in_channel",
          text: "@#{challenge.o_player}, @#{challenge.x_player} has challenged you to a game.
                 To accept, run /ttt accept"
        )
      else
        ::CommandResponse.new(text: challenge.errors.full_messages.join("\n"))
      end
    end
  end
end
