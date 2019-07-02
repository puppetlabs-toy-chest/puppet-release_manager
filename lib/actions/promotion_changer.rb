# frozen_string_literal: true

module ReleaseManager
  module Actions
    class PromotionChanger
      def initialize(request)
        @request = request
        @component = factory.create_ci_job_configs
      end

      def run
        logger.info("Starting to disable PE promotion for: #{request.source_branch}")
        clone_ci_configs
        change_promotion
      end

      private

      attr_reader :request, :component

      def change_promotion
        git_helper.use_repo(component.path) do
          git_helper.reset_hard('origin/master')
          promotion_changer.change_promotion
          commit_and_push_changes
        end
      end

      def commit_and_push_changes
        git_helper.commit("(maint) Disable PE promotion for #{request.source_branch}")
        git_helper.push
      end

      def clone_ci_configs
        cloner.clone_component(component)
      end

      def promotion_changer
        Common::PromotionChanger.new(request)
      end

      def factory
        Factories::ComponentFactory
      end

      def logger
        ReleaseManager.logger
      end

      def git_helper
        Helpers::Git
      end

      def cloner
        ReleaseManager::Common::Cloner
      end
    end
  end
end
