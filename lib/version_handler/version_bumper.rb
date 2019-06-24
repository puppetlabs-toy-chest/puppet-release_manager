# frozen_string_literal: true

module ReleaseManager
  module VersionHandler
    class VersionBumper
      ACTIONS = {
          'x' => :change_version_x,
          'y' => :change_version_y,
          'z' => :change_version_z
      }.freeze

      def initialize(args)
        @versions     = convert_version(args[:current_version])
        @release_type = args[:release_type]
      end

      def increment_version
        send(ACTIONS[release_type]) if respond_to?(ACTIONS[release_type], true)
        versions.join('.')
      end

      private

      attr_reader :versions, :release_type

      # Convert version to array of integers
      def convert_version(version_string)
        version_string.scan(/[0-9]+/).map(&:to_i)
      end

      def change_version_x
        versions[0] += 1
        versions[1] = 0
        versions[2] = 0
      end

      def change_version_y
        versions[1] += 1
        versions[2] = 0
      end

      def change_version_z
        versions[2] += 1
      end
    end
  end
end
