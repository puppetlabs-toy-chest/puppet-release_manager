# frozen_string_literal: true

module ReleaseManager
  module ComponentsDiff
    class DiffGenerator
      extend Forwardable

      def self.generate(component)
        new(component).generate!
      end

      def initialize(component)
        @component = component
        @result    = OpenStruct.new
      end

      def generate!
        git_helper.use_repo(path) { build_result }
        result
      end

      private

      attr_reader :result

      def_delegators :@component, :name, :url, :ref, :promoted?, :path

      def build_result
        git_helper.checkout(ref)
        result.commits = name.match?(/runtime/) ? runtime_diff : component_diff
      end

      def component_diff
        promoted? ? promoted_diff : not_promoted_diff
      end

      def runtime_diff
        result.tag = git_helper.describe_tags
        commits(runtime_handler.previous_version, ref)
      end

      def promoted_diff
        result.tag = git_helper.describe_tags
        commits(git_helper.describe_tags)
      end

      def not_promoted_diff
        result.tag = git_helper.describe_tags
        git_helper.checkout('master')
        commits(ref)
      end

      def commits(from_ref, to_ref = 'HEAD')
        git_helper.commits_between(from_ref, to_ref)
      end

      def runtime_handler
        RuntimeVersionExtractor
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
