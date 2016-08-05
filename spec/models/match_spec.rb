describe Match, type: :model do
  context "challenges" do
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

  context "gameplay" do
    describe '#apply_move' do
      context "happy path" do
        let(:match) {
          Match.new(
            channel: 'abc',
            status: 'game_in_progress',
            board: '.........',
            x_player: 'x_person',
            o_player: 'o_person'
           )
        }

        before do
          expect(match.turns_taken_count).to eq(0)
          expect(match.current_turn).to eq('x')

          match.apply_move(player: 'x', position: 1)
        end

        it "changes turn count if move is valid" do
          expect(match.turns_taken_count).to eq(1)
        end

        it "changes player turn if move is valid" do
          expect(match.current_turn).to eq('o')
        end
      end

      context "wrong turn" do
        let(:match) {
          Match.new(
            channel: 'abc',
            status: 'game_in_progress',
            board: '..x......',
            x_player: 'x_person',
            o_player: 'o_person'
           )
        }

        before do
          expect(match.turns_taken_count).to eq(0)
          expect(match.current_turn).to eq('x')

          expect { match.apply_move(player: 'o', position: 1) }.to raise_error(Match::TurnOutOfOrder)
        end

        it "does not change current turn" do
          expect(match.current_turn).to eq('x')
        end

        it "does not change turns taken count" do
          expect(match.turns_taken_count).to eq(0)
        end
      end
    end
  end

  context "game ending conditions" do
    describe '#declare_winner' do
      let(:xp) { 'playerX' }
      let(:op) { 'playerO' }
      let(:match) { Match.new(
        status: 'game_in_progress',
        board: 'xxx......',
        x_player: xp,
        o_player: op)
      }
      let(:winner_char) { 'x' }

      before do
        expect(match.board_inst).to receive(:get_winner).and_return(winner_char)
      end

      it "transitions to win" do
        match.declare_winner
        expect(match.winner_char).to eq(winner_char)
        expect(match.status).to eq('finished')
      end
    end

    describe 'declare_stalemate' do
      let(:match) { Match.new(
          status: 'game_in_progress',
          board: 'xoxxoxoxo',
          turns_taken_count: 9
        )
      }

      it "declares stalemate" do
        match.declare_stalemate
        expect(match.status).to eq('stalemate')
      end
    end
  end
end
