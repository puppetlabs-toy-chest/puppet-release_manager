# frozen_string_literal: true

module ReleaseManager
  module Actions
    class VersionBumper
      def initialize(request)
        @request = request
      end

      def run; end

      private

      attr_reader :request

      def components_list
        @components_list ||= Repository::ComponentYamlStore.read
      end

      def generate_response
        components_list.map do |component|
          response.components << ComponentsDiff::ResponseBuilder.new(request, component).build
        end
      end
    end
  end
end
