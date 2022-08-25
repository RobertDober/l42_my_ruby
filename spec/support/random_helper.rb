# frozen_string_literal: true

module Support
  module RandomHelper
    def random_string(prefix = nil, size: 10)
      [prefix, SecureRandom.alphanumeric(size)]
        .compact
        .join("_")
    end
  end
end

RSpec.configure do |config|
  config.include Support::RandomHelper
end
# SPDX-License-Identifier: Apache-2.0
