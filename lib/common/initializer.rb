# frozen_string_literal: true

module ReleaseManager
  module Common
    class Initializer
      class << self
        def workspace_initialize(request)
          create_dirs
          clone_agent
          clone_components(request.source_branch)
          logger.info('Done.')
          reader.components
        end

        private

        def create_dirs
          file_helper.create_dir(RELEASE_DIR)
          file_helper.create_dir(TMP_DIR)
        end

        def clone_agent
          logger.info("Cloning #{AGENT_URL}...")
          cloner.clone_agent
          logger.info("Cloned into #{AGENT_DIR}...")
        end

        def clone_components(source_branch)
          logger.info('Cloning components...')
          git_helper.use_repo(AGENT_DIR) do
            git_helper.checkout(source_branch)
            cloner.clone_async(reader.components)
          end
        end

        def component_files
          file_helper.read_dir(AGENT_DIR.join('configs', 'components', '*.json'))
        end

        def reader
          @reader ||= Common::ComponentsReader.new(component_files)
        end

        def cloner
          Common::Cloner
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
