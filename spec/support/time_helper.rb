# frozen_string_literal: true

RSpec.configure do |config|
  config.around do |example|
    if example.metadata[:frozen_time]
      require 'timecop'
      Timecop.freeze do
        example.run
      end
    else
      example.run
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
