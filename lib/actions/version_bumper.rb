# frozen_string_literal: true

module ReleaseManager
  module Actions
    class VersionBumper
      def initialize(request)
        @request = request
      end

      def run
        components_list.each { |component| update_version(component) }
      end

      def run_async
        pids = []
        components_list.each do |component|
          pids << Process.fork { update_version(component) }
        end
        pids.each { |pid| Process.waitpid(pid) }
      end

      private

      attr_reader :request

      def components_list
        @components_list ||= Repository::YamlStore.read
      end

      def update_version(component)
        git_helper.use_repo(component.path) do
          upstream_sync(component)
          VersionHandler::VersionEditor.new(component).edit
          push_changes(component)
        end
      end

      def upstream_sync(component)
        git_helper.fetch_all
        git_helper.checkout(component.branch)
        git_helper.reset_hard("origin/#{component.branch}")
      end

      def push_changes(component)
        git_helper.commit("(packaging) Bump to version #{component.version} [no-promote]")
        git_helper.push
      end

      def git_helper
        Helpers::Git
      end
    end
  end
end
