# frozen_string_literal: true

require 'securerandom'
module L42
  module Interfaces
    module MapInp
      extend self

      def call(input, pattern)
        pattern = pattern.gsub(Now, Time.now.to_i.to_s(16))
        [
          :stdout,
          input.each_with_index.map(&_map(pattern))
        ]
      end

      private

      Count    = %r{(?<!%)%c}
      FormattedCount = %r{(?<!%)%f(\d+)}
      Now      = %r{(?<!%)%x}
      Replacer = %r{(?<!%)%(?!%)}

      def _map(pattern)
        ->(record, idx) do
          _transform_inp(pattern, record, idx)
        end
      end

      def _replace_formatted(idx)
        ->match_str do
          "%0#{match_str[2..]}d" % idx
        end
      end

      def _transform_inp(pattern, record, idx)
        pattern
          .gsub(Count, idx.to_s)
          .gsub(FormattedCount, &_replace_formatted(idx))
          .gsub(Replacer, record)
          .gsub("%%", "%")
      end
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
