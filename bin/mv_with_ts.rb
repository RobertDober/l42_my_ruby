# frozen_string_literal: true

raise RuntimeError, "Do not require me" unless __FILE__ == $PROGRAM_NAME

require_relative '../lib/l42'

L42::Monad.functional_output(L42::Interfaces::WithTs, *ARGV)
# SPDX-License-Identifier: Apache-2.0
