# frozen_string_literal: true

RSpec.describe L42::DataClass do
  context "basic usage" do
    let(:basic_class) do
      Class.new do
        extend L42::DataClass

        attributes :a, :b, c: 42
      end
    end
    let(:legal_instance) { basic_class.new(1, 2, c: 3) }
    let(:legal_instance_with_default) { basic_class.new(1, 2) }

    it "legal instance" do
      expect(legal_instance.a).to eq(1)
      expect(legal_instance.b).to eq(2)
      expect(legal_instance.c).to eq(3)
    end

    it "legal instance has default value" do
      expect(legal_instance_with_default.a).to eq(1)
      expect(legal_instance_with_default.b).to eq(2)
      expect(legal_instance_with_default.c).to eq(42)
    end

    it "can raise a positional argument error (missing)" do
      expect {
        basic_class.new(1)
      }.to raise_error(L42::DataClass::PositionalArgumentError, /bad arity: expected were 2 given are 1/)
    end

    it "can raise a positional argument error (sporious)" do
      expect {
        basic_class.new(1, :a, :b)
      }.to raise_error(L42::DataClass::PositionalArgumentError, /bad arity: expected were 2 given are 3/)
    end

    it "can raise a keyword argument error" do
      expect {
        basic_class.new(1, :a, d: :b)
      }.to raise_error(L42::DataClass::KeywordArgumentError, "spurious keywords: [:d]")
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
