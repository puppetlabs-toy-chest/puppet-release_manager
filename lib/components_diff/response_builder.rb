# frozen_string_literal: true

module ReleaseManager
  module ComponentsDiff
    class ResponseBuilder
      def initialize(request, component)
        @request   = request
        @component = component
        @response  = OpenStruct.new
        post_initialize
      end

      def build
        generate_diff
        add_suggested_version
        add_maintenance_branch
        add_version_from_file
        response
      end

      private

      attr_reader :response, :component, :request

      def generate_diff
        diff = DiffGenerator.generate(component)
        response.tag = diff.tag
        response.commits = diff.commits
      end

      def add_suggested_version
        return response.suggested_version = response.tag unless version_bump?

        response.suggested_version = VersionHandler::VersionBumper.new(
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

      def add_version_from_file
        response.reported_version = VersionHandler::VersionReader.new(component).read_version
      end

      # If there were changes since the last release, component is promoted and tag is valid
      def version_bump?
        response.commits.any? && valid_tag? && component.promoted?
      end

      def valid_tag?
        /[0-9]+\.[0-9]+\.[0-9]+/.match?(response.tag)
      end

      def post_initialize
        response.name = component.name
        response.path = component.path
      end
    end
  end
end
