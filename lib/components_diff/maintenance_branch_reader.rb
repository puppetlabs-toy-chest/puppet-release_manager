# frozen_string_literal: true

module ReleaseManager
  module ComponentsDiff
    class MaintenanceBranchReader
      def initialize(args)
        @component = args[:component]
        @versions  = args[:version].split('.')
      end

      def read
        branch = []
        git_helper.use_repo(component.path) do
          branch = git_helper.branch(true).scan(scanner)
        end
        branch.empty? ? 'master' : branch.first
      end

      private

      attr_reader :component, :versions

      def git_helper
        Helpers::Git
      end

      def scanner
        /#{versions[0]}\.#{versions[1]}\.[xz]/
      end
    end
  end
end
