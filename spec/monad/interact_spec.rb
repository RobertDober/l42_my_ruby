# frozen_string_literal: true

RSpec.describe L42::Monad do
  describe "interaction between stdin and stdout" do
    let(:input) { double("input") }
    let(:output) { double("output") }

    let(:interactor) do
      ->(_input){ result }
    end

    context "stderr" do
      let(:result) { [:stderr, output] }

      it "transforms stdin to stderr" do
        expect($stdin)
          .to receive(:readlines).with(chomp: true)
          .and_return(input)

        expect($stderr)
          .to receive(:puts).with(output)

        described_class.interact(&interactor)
      end
    end

    context "stdout" do
      let(:result) { [:stdout, output] }

      it "transforms stdin to stdout" do
        expect($stdin)
          .to receive(:readlines).with(chomp: true)
          .and_return(input)

        expect($stdout)
          .to receive(:puts).with(output)

        described_class.interact(&interactor)
      end
    end

    context "bad result raises a ContractViolation" do
      let(:result) { output }

      it "transforms nothing" do
        expect($stdin)
          .to receive(:readlines).with(chomp: true)
          .and_return(input)

        expect($stderr)
          .not_to receive(:puts)
        expect($stdout)
          .not_to receive(:puts)

        expect {
          described_class.interact(&interactor)
        }.to raise_error(described_class::ContractViolation)
      end
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
