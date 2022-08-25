# frozen_string_literal: true

raise RuntimeError, "Do not require me" unless __FILE__ == $PROGRAM_NAME

require_relative '../lib/l42'

L42::Monad.interact(L42::Interfaces::TxSend)
# SPDX-License-Identifier: Apache-2.0
