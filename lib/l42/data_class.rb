# frozen_string_literal: true

module L42
  module DataClass
    class PositionalArgumentError < ArgumentError; end
    class KeywordArgumentError < ArgumentError; end

    def attributes(*args, **kwds)
      attr_reader(*args)
      attr_reader(*kwds.keys)

      define_method :initialize do |*a, **k|
        asize = a.size
        argssize = args.size
        raise PositionalArgumentError, "bad arity: expected were #{argssize} given are #{asize}\n#{a.inspect}" unless
        asize == args.size

        spourious = k.keys - kwds.keys
        raise KeywordArgumentError, "spurious keywords: #{spourious.inspect}" unless spourious.empty?

        args.zip(a).each { |name, value| instance_variable_set("@#{name}", value) }

        kwds.merge(k).each { |name, value| instance_variable_set("@#{name}", value) }

        begin
          init
        rescue NameError
          nil
        end
      end
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
