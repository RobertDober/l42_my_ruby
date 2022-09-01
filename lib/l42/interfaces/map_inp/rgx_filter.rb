# frozen_string_literal: true

module L42
  module Interfaces
    module MapInp
      module RgxFilter
        extend self
        def run(input, rgx_str, options)
          rgx = Regexp.compile(rgx_str)
          options[:sep] = "\u0000" if options.to_h[:"0"]
          [
            :stdout,
            input.filter_map(&_match_and_patterns(rgx, options))
          ]
        end

        private

        def _match_and_patterns(rgx, options)
          ->record do
            if match = rgx.match(record)
              match.to_a => _, *captures
              [record, *captures].join(options.to_h.fetch(:sep, " "))
            end
          end
        end

      end
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
