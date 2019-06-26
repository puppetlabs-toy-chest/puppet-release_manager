# frozen_string_literal: true

module ReleaseManager
  module Actions
    class Initializer
      def initialize(request)
        @request = request
      end

      def run
        logger.info('Initializing workspace...')
        logger.info("Using #{request.source_branch} as target branch...")
        store Common::Initializer.workspace_initialize(request)
      end

      private

      attr_reader :request

      def logger
        ReleaseManager.logger
      end

      def store(components)
        Repository::ComponentYamlStore.save(components)
      end
    end
  end
end
