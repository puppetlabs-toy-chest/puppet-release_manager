# frozen_string_literal: true

module ReleaseManager
  module VersionHandler
    class VersionReader
      extend Forwardable

      def initialize(component)
        @component = component
        post_initialize
      end

      def read_version
        return version if data.nil?

        file_helper.each_line(version_file_path) do |line|
          next unless regexp.match?(line)

          @version = line.scan(/\d+\.\d+\.\d+/).first
          break
        end
        version
      end

      private

      attr_reader :version_file_path, :regexp, :data, :version

      def_delegators :@component, :path, :ref, :name

      def post_initialize
        @data = VERSIONS_REGEXP[name]
        return if @data.nil?

        @regexp = data[:regexp]
        @version_file_path = path.join(data[:path])
        @version = ''
      end

      def file_helper
        Helpers::File
      end
    end
  end
end
