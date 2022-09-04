# frozen_string_literal: true

module Support
  module RandomHelper
    module ExampleGroup
      def let_random_string(name, size: 10)
        let(name) { random_string(name, size:) }
      end
    end
    def random_string(prefix = nil, size: 10)
      [prefix, SecureRandom.alphanumeric(size)]
        .compact
        .join("_")
    end
  end
end

RSpec.configure do |config|
  config.include Support::RandomHelper
  config.extend Support::RandomHelper::ExampleGroup
end
# SPDX-License-Identifier: Apache-2.0
