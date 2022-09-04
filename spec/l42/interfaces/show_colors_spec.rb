# frozen_string_literal: true

require 'ansi256'
RSpec.describe L42::Interfaces::ShowColors do
  describe "all colors" do
    let(:prefix) { (0..255).map{ color_part(_1) }.join(" ") }
    let(:prefix_rgx) { /\A#{Regexp.escape(prefix)}/ }

    let(:suffix) { (254..255).map{ bg_part(_1) }.join(" ") }
    let(:suffix_rgx) { /#{Regexp.escape(suffix)}\z/ }

    it "prints all colors to stdout" do
      described_class.() => :stdout, result
      expect(result.gsub("\n", " ")).to match(prefix_rgx)
      expect(result.gsub("\n", " ")).to match(suffix_rgx)
    end
  end

  context "show a single color" do
    context "fg" do
      (1..255).each do |fg|
        it "shows just the fg color #{fg}" do
          described_class.("--fg=#{fg}") => :stdout, result
          expect(result).to eq(color_part(fg, text: "color"))
        end
      end
    end
    context "bg" do
      (1..255).each do |bg|
        it "shows just the bg color #{bg}" do
          described_class.("--bg=#{bg}") => :stdout, result
          expect(result).to eq(bg_part(bg, text: "color"))
        end
      end
    end

    context "error handling" do
      it "complains about postional arguments" do
        described_class.("alpha", "beta") => :stderr, message
        expect(message).to eq("This script does not take any postional args, given: \e[33;1malpha beta\e[0m")
      end
    end
  end

  def bg_part(n, text: nil)
    if text
      text.bg(n)
    else
      ("bg %03d" % n).bg(n)
    end
  end

  def color_part(n, text: nil)
    if text
      text.fg(n)
    else
      ("color %03d" % n).fg(n)
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
