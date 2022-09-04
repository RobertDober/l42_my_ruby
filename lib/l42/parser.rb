# frozen_string_literal: true

require 'lab42/rgxargs'
module L42
  module Parser
    def parse(args)
      parser = Lab42::Rgxargs.new(open_struct: false, posix: true)
      case parser.parse(args)
      in options, positionals, []
        [options, positionals]
      in _, _, errors
        $stderr.puts(errors)
        exit(-1)
      end
    end
  end
end
  # SPDX-License-Identifier: Apache-2.0
