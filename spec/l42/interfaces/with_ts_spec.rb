# frozen_string_literal: true

RSpec.describe L42::Interfaces::WithTs, :frozen_time do
  context 'moves a file to a directory with ts and tags' do
    let(:tags) { %w[beta epsilon delta alpha] }
    let(:hex_now) { Time.now.to_i.to_s(16) }

    it 'keeps the extension' do
      described_class.('a_file-x.x.tmp', 'Directory', *tags) => :stdout, result
      expect(result).to eq(%(mv "a_file-x.x.tmp" "Directory/alpha-beta-delta-epsilon-#{hex_now}.tmp"))
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
