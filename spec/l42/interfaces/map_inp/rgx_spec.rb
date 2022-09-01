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

  context "rgx filtermap with default sep" do
    it "filters line in its simplest form" do
      expect(filtermap("Line"))
        .to eq(input_wo_noise)
    end

    it "filters lines with captures" do
      expect(filtermap("Line-([1,3])-(.*)"))
        .to eq(["Line-1-alpha 1 alpha", "Line-3-beta 3 beta"])
    end
  end

  context "rgx filtermap with custom sep" do
    it "filters lines with captures" do
      expect(filtermap("Line-([1,3])-(.*)", "--sep=X"))
        .to eq(["Line-1-alphaX1Xalpha", "Line-3-betaX3Xbeta"])
    end
  end

  context "rgx filtermap with \0 sep" do
    it "filters lines with captures" do
      expect(filtermap("Line-([1,3])-(.*)", "-0"))
        .to eq(["Line-1-alpha\u00001\0alpha", "Line-3-beta\u00003\0beta"])
    end
  end

  def filtermap(rgx_str, *args)
    described_class.(input, '-r', *[*args, rgx_str]) => :stdout, result
    result
  end
end
# SPDX-License-Identifier: Apache-2.0
