# frozen_string_literal: true

describe ReleaseManager::Common::PromotionChanger do
  context 'behaviour' do
    subject { ReleaseManager::Common::PromotionChanger }
    let(:request) {OpenStruct.new(source_branch: '5.5.x')}
    let(:file_path) {CI_CONFIGS_DIR.join('jenkii', 'platform', 'projects', 'puppet-agent.yaml')}

    it 'Modify PE promotion for 5.5.x' do
      expect(ReleaseManager::Factories::ComponentFactory).to receive(:create_ci_jobs_config)
      expect(ReleaseManager::Common::Cloner).to receive(:clone_component)
      expect(ReleaseManager::Helpers::Git).to receive(:use_repo).with(CI_CONFIGS_DIR).and_call_original
      expect_any_instance_of(ReleaseManager::Common::FileEditor).to receive(:edit)
      expect(ReleaseManager::Helpers::Git).to receive(:commit).with('(maint) Disable PE promotion for 5.5.x')
      expect(ReleaseManager::Helpers::Git).to receive(:push)
      subject.change_promotion(request)
    end

  end
end

