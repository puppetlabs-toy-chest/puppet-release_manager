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
        cloner.clone_agent
        git_helper.checkout(source_branch)
      end

      def prep_components
        clone_components
        components_list.each do |component|
          result[component.name] = DiffGenerator.generate(component)
        end
      end

      def clone_components
        cloner.clone_async(components_to_clone)
      end

      def components_list
        @components_list ||= component_files.map do |file_name|
          json = JSON.parse(file_helper.read(file_name))
          resolver.create_component(file_name: file_name, url: json['url'], ref: json['ref'])
        end
      end

      def components_to_clone
        components_list.reject { |component| component.url.nil? }
      end

      def component_files
        file_helper.read_dir(AGENT_DIR.join('configs', 'components', '*.json'))
      end

      def git_helper
        Helpers::Git
      end

      def file_helper
        Helpers::File
      end

      def resolver
        Common::ComponentsResolver
      end

      def cloner
        Common::Cloner
      end
    end
  end
end
