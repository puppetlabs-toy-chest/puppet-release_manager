# frozen_string_literal: true

module ReleaseManager
  module Common
    class ComponentsResolver
      def self.create_component(args)
        new(args).create_component
      end

      def initialize(args)
        @file_name = args[:file_name]
        @url       = args[:url]
        @ref       = args[:ref]
      end

      def create_component
        Entities::Component.create(
          name: resolve_name,
          url: url,
          ref: ref,
          promoted: promoted?
        )
      end

      private

      attr_reader :file_name, :url, :ref

      def promoted?
        !/module-puppetlabs|resource_api/.match?(file_name)
      end

      def resolve_name
        return file_name_to_component_name if url.nil?

        url_to_component_name
      end

      def url_to_component_name
        url.split('/').last.split('.').first
      end

      def file_name_to_component_name
        file_name.split('/').last.split('.').first
      end
    end
  end
end
