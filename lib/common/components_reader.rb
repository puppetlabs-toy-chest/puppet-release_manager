# frozen_string_literal: true

module ReleaseManager
  module Common
    class ComponentsReader
      def initialize(component_files)
        @component_files = component_files
      end

      def components
        @components ||= components_list
      end

      private

      attr_reader :component_files

      def components_list
        component_files.inject([]) { |list, file_path| list << build_component(file_path) }
      end

      def build_component(file_path)
        json = JSON.parse(file_helper.read(file_path))
        return handle_runtime(json) if /puppet-runtime/.match?(file_path)

        factory.create_component(url: json['url'], ref: json['ref'])
      end

      def handle_runtime(json)
        factory.create_component(file_name: 'puppet-runtime', url: RUNTIME_URL, ref: json['version'])
      end

      def file_helper
        Helpers::File
      end

      def factory
        Factories::ComponentFactory
      end
    end
  end
end
