# frozen_string_literal: true

require 'ex_aequo/color'

module L42
  module Interfaces
    module MapInp
      module Help
        extend self
        include ExAequo::Color
        def help
          <<~EOHELP
            usage: #{File.basename $PROGRAM_NAME} [-r0h] [--sep=] [--help] rgx_or_pattern

            #{colorize("Regex Filter", rgb: '#00ff00')}
            ------------
            if -r is given each input line is matched against the regular expression `rgx_or_pattern` and
            iff matched a line of joined fields is output.
              These fields are:
                - the matched input line
                - followed by all captures of the regular expression
            The joining string defaults to one space but can be set by the `sep` option, the option
            `-0` sets the joining string to the null character (\u0000)

            Pattern Matching
            ----------------
            If -r is not given then each input line is transformed according to the pattern `rgx_or_pattern`
            This pattern can be a fixed text with special
          EOHELP
        end
      end
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
