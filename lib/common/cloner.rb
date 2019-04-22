# frozen_string_literal: true

module ReleaseManager
  module Common
    module Cloner
      class << self
        def clone_component(component)
          unless file_helper.dir_exists?(component.path)
            git_helper.clone(component.url, component.name, path: COMPONENTS_DIR)
          end
          git_helper.use_repo(component.path)
        end

        def clone_agent
          unless file_helper.dir_exists?(AGENT_DIR)
            git_helper.clone(AGENT_URL, 'puppet-agent', path: RELEASE_DIR)
          end
          git_helper.use_repo(AGENT_DIR)
        end

        def clone_async(components)
          threads = []
          components.each do |component|
            threads << Thread.new { clone_component(component) }
          end
          threads.map(&:join)
        end

        def clone_puppet_runtime
          git_helper.clone(RUNTIME_URL, 'puppet-runtime', path: RUNTIME_DIR)
        end

        private

        def git_helper
          Helpers::Git
        end

        def file_helper
          Helpers::File
        end
      end
    end
  end
end
