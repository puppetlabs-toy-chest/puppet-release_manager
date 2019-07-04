# frozen_string_literal: true

module ReleaseManager
  module Factories
    class ComponentFactory
      class << self
        def create(args)
          Entities::Component.create(
            name: resolve_name(args[:url]),
            url: args[:url],
            ref: args[:ref],
            promoted: promoted?(args[:ref]),
            path: path(resolve_name(args[:url]))
          )
        end

        def create_ci_job_configs
          create(url: CI_CONFIGS_URL, ref: 'master')
        end

        private

        def promoted?(ref)
          !%r{refs/tags}.match?(ref)
        end

        def resolve_name(url)
          url.split('/').last.split('.').first
        end

        def path(name)
          COMPONENTS_DIR.join(name)
        end
      end
    end
  end
end
