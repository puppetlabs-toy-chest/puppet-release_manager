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
        store
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

      def store
        Repository::BumperYamlStore.save(components_to_bump)
      end

      def components_to_bump
        response.components.each_with_object([]) { |c, list| list << create_bumper(c) unless c.branch.empty? }
      end

      def create_bumper(component)
        Entities::Bumper.create(
          name: component.name,
          path: component.path,
          version: component.suggested_version,
          branch: component.branch
        )
      end
    end
  end
end
