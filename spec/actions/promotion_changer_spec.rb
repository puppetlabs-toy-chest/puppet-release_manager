# frozen_string_literal: true

describe ReleaseManager::Actions::PromotionChanger do
  context 'behaviour' do
    let(:request) { OpenStruct.new(source_branch: '5.5.x') }
    subject { ReleaseManager::Actions::PromotionChanger.new(request) }

    before do
      # clone ci-job-configs
      expect(ReleaseManager::Factories::ComponentFactory).to receive(:create_ci_job_configs).and_call_original
      expect(ReleaseManager::Common::Cloner).to receive(:clone_component)

      # cd into the repo
      expect(ReleaseManager::Helpers::File).to receive(:chdir).twice
      expect(ReleaseManager::Helpers::Git).to receive(:reset_hard)
      expect(ReleaseManager::Helpers::Git).to receive(:use_repo).with(CI_CONFIGS_DIR).and_call_original

      # change promotion flag
      expect_any_instance_of(ReleaseManager::Common::FileEditor).to receive(:edit)

      # commit and push the changes
      expect(ReleaseManager::Helpers::Git).to receive(:commit).with('(maint) Disable PE promotion for 5.5.x')
      expect(ReleaseManager::Helpers::Git).to receive(:push)
    end

    it 'modifies PE promotion' do
      subject.run
    end
  end
end

