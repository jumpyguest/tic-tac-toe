# frozen_string_literal: true

require_relative '../lib/Player'
require_relative '../lib/GameBoard'


describe Player do
  describe '#select_position' do
    context 'when the game board is empty' do
      # let(:board_empty) { instance_double(GameBoard) }
      let(:board_empty) { GameBoard.new }
      subject(:player) { described_class.new('X', board_empty) }
      error_message = "Unavailable position. Please try again."

      context 'when position is invalid, and then valid' do
        before do
          # empty_pos = [1, 2, 3, 4, 5, 6, 7, 8, 9]
          # allow(board_empty).to receive(:get_free_positions).and_return(empty_pos)
          allow(player).to receive(:gets).and_return('0', '1')
        end

        it 'returns unavailable position once' do
          expect(player).to receive(:puts).with(error_message).once
          player.select_position
        end
      end

      context 'when position is invalid twice, and then valid' do
        before do
          allow(player).to receive(:gets).and_return('0', '10', '1')
        end

        it 'returns unavailable position twice' do
          expect(player).to receive(:puts).with(error_message).twice
          player.select_position
        end
      end

      context 'when position is 1' do
        before do
          allow(player).to receive(:gets).and_return('1')
        end

        it "returns an array equal to [1]" do
          player.select_position
          expect(player.player_positions).to eq([1])
        end
      end
    end
  end
end