# frozen_string_literal: true

RSpec.describe L42::Interfaces::MapInp, :frozen_time do
  let(:input) { %w[alpha beta gamma].map { random_string _1 } }

  context "use only input" do
    it "idempotency" do
      described_class.(input, '%') => :stdout, result
      expect(result).to eq(input)
    end

    it "can be used in a string" do
      described_class.(input, 'prefix%suffix') => :stdout, result
      expected_result =
        input.map { "prefix#{_1}suffix"}
      expect(result).to eq(expected_result)
    end

    it "can be used twice in a string" do
      described_class.(input, '%prefix%suffix') => :stdout, result
      expected_result =
        input.map { "#{_1}prefix#{_1}suffix"}
      expect(result).to eq(expected_result)
    end

    it "can contain literal % by doubling them" do
      described_class.(input, '%%prefix%suffix') => :stdout, result
      expected_result =
        input.map { "%prefix#{_1}suffix"}
      expect(result).to eq(expected_result)
    end

    it "we can include the count" do
      described_class.(input, '%%prefix%suffix--%c') => :stdout, result
      expected_result =
        input.each_with_index.map { "%prefix#{_1}suffix--#{_2}"}
      expect(result).to eq(expected_result)
    end

    it "we can include a formatted count" do
      described_class.(input, '%%prefix%suffix--%f2') => :stdout, result
      expected_result =
        input.each_with_index.map { "%prefix#{_1}suffix--0#{_2}"}
      expect(result).to eq(expected_result)
    end
    it "we can escape the count" do
      described_class.(input, '%%prefix%suffix--%%c') => :stdout, result
      expected_result =
        input.map { "%prefix#{_1}suffix--%c"}
      expect(result).to eq(expected_result)
    end

    it "we can also include the timestamp" do
      now = Time.now.to_i.to_s(16)
      described_class.(input, 'prefix%-%x-%c') => :stdout, result
      expected_result =
        input.each_with_index.map { "prefix#{_1}-#{now}-#{_2}"}
      expect(result).to eq(expected_result)
    end
  end

end
# SPDX-License-Identifier: Apache-2.0
