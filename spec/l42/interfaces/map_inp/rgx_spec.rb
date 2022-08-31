# frozen_string_literal: true

RSpec.describe L42::Interfaces::MapInp, :frozen_time do
  let(:input) do
    [
      "Line-1-alpha",
      "Line-2-beta",
      "some noise",
      "Line-3-beta",
      "Line-4-gamma"
    ]
  end

  let(:input_wo_noise) do
    [
      "Line-1-alpha",
      "Line-2-beta",
      "Line-3-beta",
      "Line-4-gamma"
    ]
  end

  context "rgx filtermap" do
    it "filters line in its simplest form" do
      expect(filtermap("Line"))
        .to eq(input_wo_noise)
    end
  end

  private

  def filtermap(rgx_str)
    described_class.(input, '-r', rgx_str) => :stdout, result
    result
  end
end
# SPDX-License-Identifier: Apache-2.0
