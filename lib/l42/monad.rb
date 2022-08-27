# frozen_string_literal: true

module L42
  module Monad
    extend self

    class ContractViolation < RuntimeError; end

    def interact(interactor, *args, **kwds)
      case interactor.($stdin.readlines(chomp: true), *args, **kwds)
      in [:stdout, output]
        $stdout.puts(output)
      in [:stderr, output]
        $stderr.puts(output)
      in x
        raise ContractViolation,
              "an interactor needs to return a result of type `[:stderr|:stdout, anything]`, not #{x.inspect}"
      end
    end

    def functional_output(transformer, *args)
      case transformer.(*args)
      in [:stdout, output]
        $stdout.puts(output)
      in [:stderr, output]
        $stderr.puts(output)
      in x
        raise ContractViolation,
              "a transformer needs to return a result of type `[:stderr|:stdout, anything]`, not #{x.inspect}"
      end
    end

    def functional_input(transformer, *args, use_params: nil)
      input =
        use_params || $stdin.readlines(chomp: true)
      case transformer.(input, *args)
      in [:stdout, output]
        output
      in [:stderr, output]
        $stderr.puts(output)
        exit(-1)
      in x
        raise ContractViolation,
              "a transformer needs to return a result of type `[:stderr|:stdout, anything]`, not #{x.inspect}"
      end
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
