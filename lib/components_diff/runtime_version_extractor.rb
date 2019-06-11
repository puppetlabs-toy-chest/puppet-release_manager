# frozen_string_literal: true

module ReleaseManager
  module ComponentsDiff
    class RuntimeVersionExtractor
      RUNTIME_FILE = AGENT_DIR.join('configs', 'components', 'puppet-runtime.json')

      class << self
        def current_version
          @current_version ||= read_version
        end

        def previous_version
          return @previous_version unless @previous_version.nil?

          git_helper.use_repo(AGENT_DIR) do
            git_helper.checkout(git_helper.describe_tags)
            @previous_version = read_version
          end
          @previous_version
        end

        private

        def read_version
          file_helper.read(RUNTIME_FILE).match(/\"[0-9]+\"/).to_s
        end

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
