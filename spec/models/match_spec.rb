describe Match, type: :model do
  context "with no matches in the channel" do
    let(:x_player) { "player_x" }
    let(:o_player) { "player_x" }
    let(:channel) { "general" }
    let(:match) { Match.challenge(channel: channel, x_player: x_player, o_player: o_player) }

    describe ".challenge" do
      it "should have null accepted_at" do
        expect(match.accepted_at).to be_nil
      end

      it "should have specified params" do
        expect(match.x_player).to eq(x_player)
        expect(match.o_player).to eq(o_player)
        expect(match.channel).to eq(channel)
      end

      it "should have status challenge_open" do
        expect(match.status).to eq('challenge_open')
      end
    end

    describe "#accept_challenge" do
      before do
        match.accept_challenge(o_player)
        match.reload
      end

      it "should transition to state game_in_progress" do
        expect(match.status).to eq('game_in_progress')
      end

      it "should set accepted_at" do
        expect(match.accepted_at).to_not be_nil
      end
    end
  end
end
