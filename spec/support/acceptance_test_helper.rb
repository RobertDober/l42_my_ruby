# frozen_string_literal: true

module Support
  module AcceptanceTestHelper
    def fixture_content(fixture_file)
      File.readlines(fixture_path(fixture_file), chomp: true)
    end

    def fixture_path(*segments)
      File.join(File.dirname(__dir__), "fixtures", *segments)
    end

    def run_binary(name, *args, input: nil)
      if input
        %x(./bin/#{name} #{args.join(" ")} < spec/fixtures/#{input})
          .split("\n")
      else
        %x(./bin/#{name} #{args.join(" ")})
          .split("\n")
      end
    end
  end
end

RSpec.configure do |config|
  config.include Support::AcceptanceTestHelper, type: :acceptance_test
end
# SPDX-License-Identifier: Apache-2.0
