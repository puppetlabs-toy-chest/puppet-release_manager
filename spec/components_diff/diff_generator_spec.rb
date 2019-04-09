describe ReleaseManager::ComponentsDiff::DiffGenerator do
  context 'interface' do
    subject { ReleaseManager::ComponentsDiff::DiffGenerator.new(build(:component)) }

    it { is_expected.to respond_to(:generate!) }
  end

  context 'behaviour' do
    let(:component) { build(:component) }
    let(:diff_generator) { ReleaseManager::ComponentsDiff::DiffGenerator.new(component) }

    before(:each) do
      allow(ReleaseManager::Helpers::Git).to receive(:use_repo)
    end

    it 'generates the correct diff for promoted components' do
      expect(diff_generator).to receive(:promoted_diff)
      diff_generator.generate!
    end

    it 'generates the correct diff for components that are not promoted' do
      allow(component).to receive(:promoted?).and_return false
      expect(diff_generator).to receive(:not_promoted_diff)
      diff_generator.generate!
    end
  end
end
