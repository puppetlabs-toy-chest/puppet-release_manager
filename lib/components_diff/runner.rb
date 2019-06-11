# frozen_string_literal: true

module ReleaseManager
  module ComponentsDiff
    class Runner
      def self.run(request)
        new(request.source_branch, request.release_type).run
      end

      def initialize(source_branch, release_type)
        @source_branch = source_branch
        @release_type = release_type
        @result = {}
      end

      def run
        generate_diff
      end

      private

      attr_reader :source_branch, :release_type, :result

      def fill_revision_field(name)
        result[name] = Common::VersionHandler.new(component: result[name],
                                                  release_type: release_type,
                                                  name: name).add_versions
      end
    end
  end
end
