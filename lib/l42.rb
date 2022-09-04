# frozen_string_literal: true



require 'lab42/monad'
Monad = Lab42::Monad

require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.setup # ready!
# loader.eager_load # optionally

require_relative "l42/version"
module L42
end

# SPDX-License-Identifier: Apache-2.0
