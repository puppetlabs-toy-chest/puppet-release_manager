# frozen_string_literal: true

module ReleaseManager
  module Actions
    class PromotionChanger
      def initialize(request)
        @request = request
      end

      def run
        logger.info("Starting to disable PE promotion for: #{request.source_branch}")
        Common::PromotionChanger.change_promotion(request)
      end

      private

      attr_reader :request

      def logger
        ReleaseManager.logger
      end
    end
  end
end
