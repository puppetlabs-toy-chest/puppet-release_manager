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
      end

      def generate!
        return commits_for_runtime if name.match?(/runtime/)

        if url.nil?
          return {
            tag: 'No URL provided.',
            commits: []
          }
        end
        generate_diff
      end

      private

      def_delegators :@component, :name, :url, :ref, :promoted?, :path

      def generate_diff
        git_helper.use_repo(path)
        promoted? ? promoted_diff : not_promoted_diff
      end

      def commits_for_runtime
        extracter = RuntimeVersionExtracter.new
        {
          tag: extracter.extract_version,
          commits: extracter.extract(path)
        }
      end

      def promoted_diff
        git_helper.checkout(ref)
        {
          tag: git_helper.describe('HEAD', tags: true),
          commits: git_helper.commits_between(
            git_helper.describe('HEAD', tags: true, abbrev: 0),
            'HEAD'
          )
        }
      end

      def not_promoted_diff
        git_helper.checkout('master')
        {
          tag: ref,
          commits: git_helper.commits_between(
            ref,
            'HEAD'
          )
        }
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
