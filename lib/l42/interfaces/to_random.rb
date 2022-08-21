# frozen_string_literal: true

require 'lab42/rgxargs'
require 'securerandom'
module L42
  module Interfaces
    module ToRandom
      extend self

      def call(files)
        Lab42::Rgxargs.new.parse(ARGV) => [kwds, args, *]
        [
          :stdout,
          files.map(&_random_file(args, kwds))
        ]
      end

      private

      def _random_file(_args, kwds)
        ->file do
          ext = File.extname(file)
          name = SecureRandom.hex((kwds.hex || 10).to_i)
          ["mv #{file.inspect} ", name, ext].join
        end
      end
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
