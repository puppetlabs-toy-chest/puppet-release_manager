# frozen_string_literal: true

module ReleaseManager
  module VersionHandler
    class VersionEditor
      def initialize(component)
        @component = component
        post_initialize
      end

      def edit
        Common::FileEditor.new(file_path: file_path).edit(&self)
      end

      private

      attr_reader :component, :file_path, :regexp

      def to_proc
        proc do |line|
          if regexp.match?(line)
            line.gsub(/\d+\.\d+\.\d+/, component.version)
          else
            line
          end
        end
      end

      def post_initialize
        version_data = VersionHandler::VERSIONS_REGEXP[component.name]
        raise "Missing file path and regexp for #{component.name}" if version_data.nil?

        @file_path = component.path.join(version_data[:path])
        @regexp    = version_data[:regexp]
      end
    end
  end
end
