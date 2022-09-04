# frozen_string_literal: true

require 'lab42/rgxargs'
module L42
  module Interfaces
    module ShowColors
      extend self

      C = Tools::Colorize
      def call(*args)
        parser = Lab42::Rgxargs.new(posix: true)
        case parser.parse(args)
        in options, [], _
          [:stdout, _show_colors(options)]
        in _, positionals, _
          [:stderr, "This script does not take any postional args, given: #{C.color(positionals.join(" "), fg: :yellow, bold: true)}"]
        end
      end

      private

      def _show_all_colors
        (0...16).map do |base|
          (0...16).map do |unit|
            color = 16*base + unit
            C.color("color #{"%03d" % color}", fg: color)
          end.join(" ")
        end.join("\n") + "\n" +
        (0...16).map do |base|
          (0...16).map do |unit|
            color = 16*base + unit
            C.color("bg #{"%03d" % color}", bg: color)
          end.join(" ")
        end.join("\n")
      end

      def _show_color(options)
        case options
        in fg:
          C.color("color", fg: fg.to_i, bold: options.bold)
        in bg:
          C.color("color", bg: bg.to_i, bold: options.bold)
        end
      end

      def _show_colors(options)
        if options.to_h.empty?
          _show_all_colors
        else
          _show_color(options)
        end
      end
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
