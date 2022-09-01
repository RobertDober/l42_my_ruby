# frozen_string_literal: true

RSpec.describe L42::Interfaces::MapInp, :frozen_time do
  context "ws seperated fields" do
    let(:input) { [
      "alpha first ALPHA",
      "beta second BRAVO"
    ] }
    it "accessing field N° 2" do
      described_class.(input, '%2 %') => :stdout, result
      expect(result).to eq([
        'first alpha first ALPHA',
        'second beta second BRAVO'
      ])
    end

    it "can acess many fields and multiple times" do
      described_class.(input, '%2 %2 %1 %2') => :stdout, result
      expect(result).to eq([
        'first first alpha first',
        'second second beta second'
      ])
    end
  end

  context "zero delimited fields" do
    let(:input) { [
      %w[William Shakespeare].join("\0"),
      %w[Jean-Baptiste Molière].join("\0")
    ] }
    it "can be instructed with the -0 switch" do
      described_class.(input, '-0', '%2, %1') => :stdout, result
      expect(result).to eq([
      "Shakespeare, William",
      "Molière, Jean-Baptiste"
      ])
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
