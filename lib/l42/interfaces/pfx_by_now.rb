# frozen_string_literal: true

require 'lab42/rgxargs'
require 'securerandom'
module L42
  module Interfaces
    module PfxByNow
      extend self

      def call(files)
        now = Time.now.to_i.to_s(16)
        [
          :stdout,
          files.map(&_pfx_by_now(now))
        ]
      end

      private

      def _pfx_by_now(now)
        ->file do
          ["mv", file.inspect, [now, file].join("_").inspect ].join(" ")
        end
      end
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
