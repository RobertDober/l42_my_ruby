# frozen_string_literal: true

RSpec.describe L42::Monad do
  describe "args and stdin produce result" do
    let(:input) { (1..3).to_a.map(&:to_s) }

    context "ok result" do
      let(:transformer) { ->(lines, base) { [:stdout, lines.inject(base){ |b, l| b + l.to_i} ] } }
      it "computes on input" do
        expect($stdin)
          .to receive(:readlines).with(chomp: true)
          .and_return(input)

        expect(described_class.functional_input(transformer, 10)).to eq(16)
      end
    end

    context "error result" do
      let(:message) { random_string("error") }
      let(:transformer) { ->(_) { [:stderr, message] }}
      it "will exit" do
        expect($stdin)
          .to receive(:readlines).with(chomp: true)
          .and_return(input)

        expect($stderr)
          .to receive(:puts).with(message)

        expect { described_class.functional_input(transformer) }
          .to raise_error(SystemExit)
      end
    end

    context "bad result raises a ContractViolation" do
      let(:transformer) { ->(_) { 42 } }
      it "transforms nothing" do
        expect($stdin)
          .to receive(:readlines).with(chomp: true)
          .and_return(input)

        expect($stderr)
          .not_to receive(:puts)
        expect($stdout)
          .not_to receive(:puts)

        expect {
          described_class.functional_input(transformer)
        }.to raise_error(described_class::ContractViolation)
      end
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
