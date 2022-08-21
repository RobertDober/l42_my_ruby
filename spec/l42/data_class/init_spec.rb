# frozen_string_literal: true

RSpec.describe L42::DataClass do
  context "init usage" do
    let(:init_class) do
      Class.new do
        extend L42::DataClass

        attributes :a, :b, c: 42

        private

        def init
          @b = a + b + c
        end
      end
    end

    let(:legal_instance) { init_class.new(1, 2, c: 3) }
    let(:legal_instance_with_default) { init_class.new(1, 2) }

    it "legal instance" do
      expect(legal_instance.b).to eq(6)
    end

    it "legal instance has default value" do
      expect(legal_instance_with_default.b).to eq(45)
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
