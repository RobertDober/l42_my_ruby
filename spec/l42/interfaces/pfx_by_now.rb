# frozen_string_literal: true

RSpec.describe L42::Interfaces::PfxByNow, :frozen_time do
  let(:now) { Time.now.to_i.to_s(16) }
  let(:files) { %w[a.one two.b.c three] }

  it "moves them with the ts prefixed" do
    described_class.(files) => :stdout, result
    expected_result =
      files.map { %(mv "#{_1}" "#{now}_#{_1}") }
    expect(result)
      .to eq(expected_result)
  end

end
# SPDX-License-Identifier: Apache-2.0
