# frozen_string_literal: true

module ReleaseManager
  module Actions
    class Diff
      def initialize(request)
        @request  = request
        @response = OpenStruct.new
        response.components = []
      end

      def run
        generate_response
        response
      end

      private

      attr_reader :request, :response

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
