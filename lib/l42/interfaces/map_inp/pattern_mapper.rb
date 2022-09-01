# frozen_string_literal: true

module L42
  module Interfaces
    module MapInp
      module PatternMapper
        extend self

        def run(input, pattern, options)
          options[:sep] = "\u0000" if options[:"0"]
          _compile(pattern, options) => pattern, options, field_rgxn

          [
            :stdout,
            input.each_with_index.map(&_map(pattern, options, field_rgxn))
          ]
        end

        private

        Count    = %r{(?<!%)%c}
        FieldId  = %r{(?<!%)%(\d+)}
        FormattedCount = %r{(?<!%)%f(\d+)}
        Now      = %r{(?<!%)%x}
        Replacer = %r{(?<!%)%(?!%)}

        def _compile(pattern, options)
          pattern = pattern.gsub(Now, Time.now.to_i.to_s(16))

          max_field = pattern.scan(FieldId).flatten.map(&:to_i).max
          options[:max_field] = max_field
          field_rgxen =
            (1..max_field||0).map { |nb| %r{(?<!%)%#{nb}(?!\d)} }
          [pattern, options, field_rgxen]
        end

        def _map(pattern, options, field_rgxen)
          ->(record, idx) do
            _transform_inp(pattern, record, idx, options, field_rgxen)
          end
        end

        def _replace_formatted(idx)
          ->match_str do
            "%0#{match_str[2..]}d" % idx
          end
        end

        def _transform_inp(pattern, record, idx, options, field_rgxen)
          if options[:max_field]
            _transform_splitting(pattern, record, idx, options, field_rgxen)
          else
            _transform_plain(pattern, record, idx)
          end
        end

        def _transform_plain(pattern, record, idx)
          pattern
            .gsub(Count, idx.to_s)
            .gsub(FormattedCount, &_replace_formatted(idx))
            .gsub(Replacer, record)
            .gsub("%%", "%")
        end

        def _transform_splitting(pattern, record, idx, options, field_rgxn)
          fields = record.split(options[:sep]||%r{\s+}, options[:max_field].succ)
          output = pattern
            .gsub(Count, idx.to_s)
            .gsub(FormattedCount, &_replace_formatted(idx))

          output = (0...options[:max_field]).inject(output) do |out, field_nb|
            out.gsub(field_rgxn[field_nb], fields[field_nb])
          end
          output
            .gsub(Replacer, record)
            .gsub("%%", "%")
        end
      end
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
