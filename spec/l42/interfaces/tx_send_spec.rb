# frozen_string_literal: true

RSpec.describe L42::Interfaces::TxSend, :frozen_time do
  context "sending a file" do
    let(:input) { [%(line "one"), %('second' line)] }
    let(:dest) { random_string("dest", size: 4) }

    it 'creates the following output' do
      output = [
        "tmux send-keys -t #{dest} 'line \"one\"' C-m",
        "tmux send-keys -t #{dest} ''second' line' C-m",
        "tmux select-window -t #{dest}"
      ]
      ARGV = [dest]
      expect(
        described_class.(input)
      ).to eq([:stdout, output])
    end
  end
end

# SPDX-License-Identifier: Apache-2.0
