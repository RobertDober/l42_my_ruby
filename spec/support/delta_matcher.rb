# frozen_string_literal: true

require 'ex_aequo/color'

module Support
  class LineDelta
    def message
      actual = @actual.each_with_index
      errors = format_deltas(actual.zip(@expected))
      errors + missing(actual, @expected.each_with_index)
      puts errors
      errors
    end

    private

    def act(txt)
      ExAequo::Color.colorize(txt, ansi: :red)
    end

    def exp(txt)
      ExAequo::Color.colorize(txt, ansi: :green)
    end

    def format_delta(a, e, idx)
      [
        "Line #{idx.succ}",
        act(a),
        exp(e)
      ].join("\n")
    end

    def format_deltas(pairs)
      pairs.reduce([]) do |r, ((av, ai), ev)|
        if av == ev
          r
        else
          r << format_delta(av, ev, ai)
        end
      end
    end

    def initialize(actual, expected)
      @actual = actual
      @expected = expected
    end

    def missing(actual, expected)
      if actual.size < expected.size
        expected
          .drop(actual.size)
          .map { _format_delta('', _1, _2) }
      else
        []
      end
    end
  end
end
RSpec::Matchers.define :be_same_lines do |expected|
  match { |actual| actual == expected }

  failure_message do |actual|
    Support::LineDelta.new(actual, expected).message
  end
end
# SPDX-License-Identifier: Apache-2.0
