# frozen_string_literal: true

require 'lab42/rgxargs'
module L42
  module Interfaces
    module TxSendFile
      extend self

      def call(filename, dest)
        [
          :stdout,
          [*File.readlines(filename, chomp: true).map(&_send_to(dest)), "tmux select-window -t #{dest}"]
        ]
      end

      private

      def _send_to(dest)
        ->line do
          %(tmux send-keys -t #{dest} '#{line.shellescape}' C-m)
        end
      end
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
