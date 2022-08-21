# frozen_string_literal: true

module L42
  module Interfaces
    module WithTs
      extend self
      def call(file_name, dest_dir, *tags)
        [
          :stdout,
          %(mv #{file_name.inspect} #{File.join(dest_dir, _make_tagged_name(file_name, tags)).inspect})
        ]
      end

      private
      def _make_tagged_name(file_name, tags)
        [*tags.sort, Time.now.to_i.to_s(16)].join("-") + File.extname(file_name)
      end
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
