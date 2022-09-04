# frozen_string_literal: true

require 'securerandom'

module L42
  module Interfaces
    module MapInp
      extend self

      def call(input, *args, **options)
        if options.r
          RgxFilter.run(input, positionals.first, options)
        else
          PatternMapper.run(input, positionals.first, options)
        end
      end
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
