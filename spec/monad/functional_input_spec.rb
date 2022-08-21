# frozen_string_literal: true

RSpec.describe L42::Monad do
  describe "interaction between args and stdout" do
    let(:output) { double("output") }

    let(:transformer) do
      ->(*){ result }
    end

    context "stderr" do
      let(:result) { [:stderr, output] }

      it "transforms args to stderr" do
        expect($stderr)
          .to receive(:puts).with(output)

        described_class.functional_output([], &transformer)
      end
    end

    context "stdout" do
      let(:result) { [:stdout, output] }

      it "transforms args to stdout" do
        expect($stdout)
          .to receive(:puts).with(output)

        described_class.functional_output([], &transformer)
      end
    end

    context "bad result raises a ContractViolation" do
      let(:result) { output }

      it "transforms nothing" do
        expect($stderr)
          .not_to receive(:puts)
        expect($stdout)
          .not_to receive(:puts)

        expect {
          described_class.functional_output([], &transformer)
        }.to raise_error(described_class::ContractViolation)
      end
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
