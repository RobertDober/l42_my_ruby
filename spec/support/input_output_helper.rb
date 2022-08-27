# frozen_string_literal: true

module Support
  module InputOutputHelper
    def capture(stream = $stdout, &blk)
      result = []
      allow(stream)
        .to receive(:puts){ |arg| result << arg }
      blk.()
      result
    end

    def capture_both(&blk)
      result = { stdout: [], stderr: [] }

      allow($stdout)
        .to receive(:puts){ |arg| result[:stdout] << arg }
      allow($stderr)
        .to receive(:puts){ |arg| result[:stderr] << arg }
      blk.()

      result
    end
  end
end

RSpec.configure do |config|
  config.include Support::InputOutputHelper
end
# SPDX-License-Identifier: Apache-2.0
