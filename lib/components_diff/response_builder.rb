# frozen_string_literal: true

module ReleaseManager
  module ComponentsDiff
    class ResponseBuilder
      def initialize(request, component)
        @request   = request
        @component = component
        @response  = OpenStruct.new
      end

      def build
        generate_diff
        add_suggested_version
        add_maintenance_branch
        response
      end

      private

      attr_reader :response, :component, :request

      def generate_diff
        diff = DiffGenerator.generate(component)
        response.name = component.name
        response.tag = diff.tag
        response.commits = diff.commits
      end

      def add_suggested_version
        return response.suggested_version = response.tag unless version_bump?

        response.suggested_version = Common::VersionHandler.new(
          release_type: request.release_type,
          current_version: response.tag
        ).increment_version
      end

      def add_maintenance_branch
        return response.branch = '' unless version_bump?

        response.branch = MaintenanceBranchReader.new(
          component: component,
          version: response.suggested_version
        ).read
      end

      # If there were changes since the last release, component is promoted and tag is valid
      def version_bump?
        response.commits.any? && valid_tag? && component.promoted?
      end

      def valid_tag?
        /[0-9]+\.[0-9]+\.[0-9]+/.match?(response.tag)
      end
    end
  end
end
