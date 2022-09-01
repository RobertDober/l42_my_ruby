# frozen_string_literal: true

require 'securerandom'
require 'lab42/rgxargs'

module L42
  module Interfaces
    module MapInp
      extend self

      def call(input, *args)
        parser = Lab42::Rgxargs.new(posix: true)
        parser.parse(args) => options, positionals, _

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
