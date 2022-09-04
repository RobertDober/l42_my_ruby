# frozen_string_literal: true

RSpec.describe L42::Tools::Colorize do
  context "honoring the NO_COLOR environnement variable", env: {NO_COLOR: 1} do
    let_random_string(:text)
    it "makes color an idempotent function" do
      expect(described_class.color(text)).to eq(text)
    end
  end

  describe "fg" do
    (0..0).each do |fg|
      it "creates the ansi codes for foreground color #{fg}" do
        expect(described_class.color("foreground #{fg}", fg:))
          .to eq("\e[38;5;#{fg}mforeground #{fg}\e[0m")
      end
    end
  end

  describe "bg" do
    (0..0).each do |bg|
      it "creates the ansi codes for background color #{bg}" do
        expect(described_class.color("background #{bg}", bg:))
          .to eq("\e[48;5;#{bg}mbackground #{bg}\e[0m")
      end
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
