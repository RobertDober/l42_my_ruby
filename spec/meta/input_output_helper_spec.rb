# frozen_string_literal: true

RSpec.describe Support::InputOutputHelper do
  let(:some_text) { random_string("some text", size: 20) }
  let(:more_text) { random_string("more text", size: 20) }

  context "Simple example that shows that capturing output from puts works" do
    it "for stdout" do
      expect(
        capture { puts some_text }
      ).to eq([some_text])
    end

    it "with explicit $stdout and more text" do
      expect(
        capture { puts some_text; $stdout.puts more_text }
      ).to eq([some_text, more_text])
    end

    it "for $stderr too" do
      expect(
        capture($stderr) { $stderr.puts some_text; $stderr.puts more_text }
      ).to eq([some_text, more_text])
    end

    it "for both streams" do
      result = capture_both do
        $stderr.puts more_text
        $stdout.puts some_text
        $stderr.puts some_text
        puts more_text
      end

      expect(result)
        .to eq(stdout: [some_text, more_text], stderr: [more_text, some_text])
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
