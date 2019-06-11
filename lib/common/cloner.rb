# frozen_string_literal: true

module ReleaseManager
  module Common
    module Cloner
      class << self
        def clone_component(component)
          logger.info("Cloning #{component.name}: #{component.url} into #{component.path}")
          git_helper.clone(component.url, component.path) unless file_helper.dir_exists?(component.path)
          fetch_all(component.path)
        end

        def clone_agent
          git_helper.clone(AGENT_URL, AGENT_DIR) unless file_helper.dir_exists?(AGENT_DIR)
          fetch_all(AGENT_DIR)
        end

        def clone_async(components)
          threads = []
          components.each do |component|
            threads << Thread.new { clone_component(component) }
          end
          threads.map(&:join)
        end

        private

        def fetch_all(path)
          git_helper.use_repo(path) { git_helper.fetch_all }
        end

        def git_helper
          Helpers::Git
        end

        def file_helper
          Helpers::File
        end

        def logger
          ReleaseManager.logger
        end
      end
    end
  end
end
