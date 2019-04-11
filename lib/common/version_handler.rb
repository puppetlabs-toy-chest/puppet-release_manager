# frozen_string_literal: true

module ReleaseManager
  module Common
    class VersionHandler
      attr_reader :component, :release_type, :name

      def initialize(args)
        @component    = args[:component]
        @release_type = args[:release_type]
        @name         = args[:name]
      end

      def change_version
        if !release_type || release_type == 'z'
          change_version_z
        else
          change_version_y
        end
      end

      def add_versions
        return component if should_add_versions?

        component[:current_version] = extract_revision
        component[:suggested] = calculate_next
        component
      end

      def should_add_versions?
        name.match?(/core|runtime|api/)
      end

      private

      def extract_revision
        component[:tag].match(/[0-9]+\.[0-9]+\.[0-9]+/).to_s
      end

      def calculate_next
        component[:current_version] unless component[:commits].any?

        change_version
      end

      def change_version_z
        component[:current_version].gsub(/[0-9]+$/) { |s| (s.to_i + 1).to_s }
      end

      def change_version_y
        component[:suggested] = component[:current_version].gsub(/\.[0-9]+\./) do |s|
          ".#{(s.delete('.').to_i + 1)}."
        end
        component[:suggested].gsub(/[0-9]+$/, '0')
      end
    end
  end
end
