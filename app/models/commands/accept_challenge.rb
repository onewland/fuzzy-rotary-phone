module Commands
  class AcceptChallenge < Command
    def execute
      o_player = @ctx[:user_name]
      channel = @ctx[:channel_name]

      begin
        challenge = Challenge.accept_challenge(channel: channel, o_player: o_player)

        if challenge.errors.empty?
          channel_output = "#{challenge.o_player} has accepted #{challenge.x_player}'s challenge.\n"
          channel_output << "It is currently #{challenge.current_user_name}'s turn\n"
          channel_output << challenge.board_inst.display

          CommandResponse.new(response_type: 'in_channel', text: channel_output)
        else
          CommandResponse.new(text: challenge.errors.full_messages.join("\n"))
        end
      rescue Challenge::ChallengeNotFound
        CommandResponse.new(text: "No challenge to accept in this channel.")
      end
    end
  end
end
