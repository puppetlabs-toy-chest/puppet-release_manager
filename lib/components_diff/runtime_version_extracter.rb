# frozen_string_literal: true

module ReleaseManager
  module ComponentsDiff
    class RuntimeVersionExtracter
      RUNTIME_FILE = ReleaseManager::AGENT_DIR.join('configs/components', 'puppet-runtime.json')

      attr_reader :previous_tag, :current_tag

      def extract(path)
        current_tag = extract_version
        git_helper.use_repo(AGENT_DIR)
        git_helper.checkout(go_to_next)
        previous_tag = extract_version
        git_helper.use_repo(path)
        git_helper.commits_between(previous_tag, current_tag)
      end

      def extract_version
        content = file_helper.read(RUNTIME_FILE)
        version = content.match(/\"[0-9]+\"/).to_s
        version.match(/[0-9]+/).to_s
      end

      def go_to_next
        s = git_helper.describe('HEAD', tags: true)
        s.match(/[0-9]+\.[0-9]+\.[0-9]+/).to_s
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
