# frozen_string_literal: true

RSpec.describe L42::Interfaces::ToRandom do
  let(:files) { %w[a.one two.b.c three] }
  let(:doubles) { files.map { double(_1) } }

  context "moves a file to a directory with ts and tags" do
    let :expected_result do
      files.zip(doubles).map do |file, double|
        "mv #{file.inspect} #{double}#{File.extname(file)}"
      end
    end

    it "creates random hex names of size 10" do
      doubles.each do |double|
        expect(SecureRandom).to receive(:hex).with(10).and_return double
      end
      described_class.(files) => :stdout, result

      expect(result).to eq(expected_result)
    end
  end

  context "" do
  end
end
# SPDX-License-Identifier: Apache-2.0
