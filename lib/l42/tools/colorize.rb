# frozen_string_literal: true

require 'ansi256'

module L42
  module Tools
    module Colorize
      extend self

      def color(text, fg: :blue,  bg: nil, bold: false)
        return text unless _color?

        _colorize(text, fg:, bg:)
          .send(bold ? :bold : :itself)
      end

      private

      def _color?
        !ENV["NO_COLOR"]
      end

      def _colorize(text, fg:, bg:)
        { fg:, bg: }
          .compact
          .inject(text) do |txt, (mthd, value)|
            text.send(mthd, value)
          end
      end
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
