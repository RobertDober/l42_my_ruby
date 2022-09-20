# frozen_string_literal: true

RSpec.describe "bin/map_inp", type: :acceptance_test do
  context "help" do
    it "writes the correct information to stdout" do
      output = run_binary("map_inp", "-h")
      p output
      expect(output).to eq(fixture_content(input_file))
    end
  end

  context "with pattern" do
    it 'copies the input' do
      input_file = "alpha_beta.txt"
      output = run_binary("map_inp", "%", input: input_file)
      expect(output).to eq(fixture_content(input_file))
    end
  end

  context "with filter" do
    let(:input_file) { "lines.txt" }
    it "outputs just filtered lines" do
      output = run_binary("map_inp", "-r", "Line", input: input_file)
      expect(output)
        .to eq(fixture_content(input_file).grep(/Line/))
    end

    it "can also output capture groups" do
      output = run_binary("map_inp", "-r", "'Line-(\\d)-(.*)'", input: input_file)
      expected_output = [
        "Line-1-one 1 one",
        "Line-2-two 2 two",
        "Line-3-three 3 three"
      ]
      expect(output).to eq(expected_output)
    end

    it "can prepare the output for machine parsing with the \u0000 seperator" do
      output = run_binary("map_inp", "-r0", "'Line-(\\d)-(.*)'", input: input_file)
      expected_output = [
        "Line-1-one\u00001\u0000one",
        "Line-2-two\u00002\u0000two",
        "Line-3-three\u00003\u0000three"
      ]
      expect(output).to eq(expected_output)
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
