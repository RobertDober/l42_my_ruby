# frozen_string_literal: true

module Support
  module EnvHelper
    extend self
    def store(env)
      case env
      in nil
        {}
      in Hash
        _store(env)
      else
        raise ArgumentError, "env not a Hash"
      end
    end

    def restore(env)
      _set_env!(env)
    end

    private

    def _store(env)
      env.inject({}) do |s, (k, _)|
        s.merge(k => ENV[k.to_s])
      end.tap {_set_env!(env) }
    end

    def _set_env!(env)
      env.each do |k, v|
        if v
          ENV[k.to_s] = v.to_s
        else
          ENV[k.to_s] = nil
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.around do |example|
    env = example.metadata[:env]
    stored = Support::EnvHelper.store(env)
    example.run
    Support::EnvHelper.restore(stored)
  end
end
# SPDX-License-Identifier: Apache-2.0
