# frozen_string_literal: true

module ReleaseManager
  module ComponentsDiff
    class Runner
      def self.run(source_branch)
        new(source_branch).run
      end

      def initialize(source_branch)
        @source_branch = source_branch
        @result        = {}
      end

      def run
        prep_agent
        prep_components
        result
      end

      private

      attr_reader :source_branch, :result

      def prep_agent
        file_helper.create_dir(RELEASE_DIR)
        clone_agent
        git_helper.fetch_all
        git_helper.checkout(source_branch)
      end

      def prep_components
        resolver.each_component do |name, url, ref|
          result[name] = DiffGenerator.generate(name, url, ref)
        end
      end

      def clone_agent
        unless file_helper.dir_exists?(AGENT_DIR)
          git_helper.clone(AGENT_URL, 'puppet-agent', path: RELEASE_DIR)
        end
        git_helper.use_repo(AGENT_DIR)
      end

      def git_helper
        Helpers::Git
      end

      def file_helper
        Helpers::File
      end

      def resolver
        ComponentsResolver
      end
    end
  end
end
