# frozen_string_literal: true

module ReleaseManager
  module ComponentsDiff
    class DiffGenerator
      def self.generate(args)
        new(args).generate
      end

      def initialize(args)
        @name      = args[:name]
        @url       = args[:url]
        @ref       = args[:ref]
        @is_module = args[:is_module]
      end

      def generate
        if url.nil?
          return {
            tag: 'No URL provided.',
            commits: []
          }
        end
        clone_component
        generate_diff
      end

      private

      attr_reader :name, :url, :ref, :is_module

      def clone_component
        component_path = COMPONENTS_DIR.join(name)
        unless file_helper.dir_exists?(component_path)
          git_helper.clone(url, name, path: COMPONENTS_DIR)
        end
        git_helper.use_repo(component_path)
      end

      def generate_diff
        is_module ? module_diff : component_diff
      end

      def component_diff
        git_helper.checkout(ref)
        {
          tag: git_helper.describe('HEAD', tags: true),
          commits: git_helper.commits_between(
            git_helper.describe('HEAD', tags: true, abbrev: 0),
            'HEAD'
          )
        }
      end

      def module_diff
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
