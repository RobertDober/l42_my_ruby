# frozen_string_literal: true

require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.setup # ready!
# loader.eager_load # optionally

module L42
  # ...
end

# SPDX-License-Identifier: Apache-2.0
