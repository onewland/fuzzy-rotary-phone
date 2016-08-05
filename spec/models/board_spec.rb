describe Board, type: :model do
  describe "#apply_move" do
    context "on an empty space" do
      let(:board) { Board.from_descriptor("." * 9) }

      it "changes the contents" do
        expect(board.contents[5]).to eq(".")
        board.apply_move('x', 5)
        expect(board.contents[5]).to eq("x")
      end
    end

    context "on a taken space" do
      let(:board) { Board.from_descriptor("x" * 9) }

      it "raises an exception" do
        expect(board.contents[5]).to eq("x")
        expect{ board.apply_move('x', 5) }.to raise_error(Board::BoardSpaceTaken)
      end
    end
  end

  describe '#get_winner' do
    context "with no winner" do
      let(:board) {
        Board.new(
          ['o','x','o',
           'o','x','o',
           'x','o','x']
        )
      }

      it "returns nil/false" do
        expect(board.get_winner).to be_falsey
      end
    end

    context "with an 'o' column win" do
      let(:board) {
        Board.new(
          ['o','x','x',
           'o','x','o',
           'o','o','x']
        )
      }

      it 'returns x' do
        expect(board.get_winner).to eq('o')
      end
    end

    context "with an 'x' row win" do
      let(:board) {
        Board.new(
          ['x','x','x',
           'x','o','o',
           'o','.','.']
        )
      }

      it 'returns x' do
        expect(board.get_winner).to eq('x')
      end
    end

    context "with an 'o' diag win" do
      let(:board) {
        Board.new(
          ['x','x','o',
           'x','o','o',
           'o','.','x']
        )
      }

      it 'returns x' do
        expect(board.get_winner).to eq('o')
      end
    end
  end
end
