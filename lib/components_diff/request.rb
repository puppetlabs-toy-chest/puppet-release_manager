# frozen_string_literal: true

module ReleaseManager
  module ComponentsDiff
    class Request
      attr_reader :source_branch, :release_type

      def initialize(args)
        @source_branch = args[:source_branch]
        @release_type  = args[:release_type]
      end
    end
  end
end
