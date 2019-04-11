# frozen_string_literal: true

describe ReleaseManager::ComponentsDiff::Runner do
  subject { ReleaseManager::ComponentsDiff::Runner.new('master','z') }

  context 'interface' do
    it { is_expected.to respond_to(:run) }
  end

  context 'behaviour' do
    context 'agent preparation' do
      before(:each) do
        allow(subject).to receive(:prep_components)
      end

      after(:each) do
        subject.run
      end

      it 'creates the release dir and clones the agent' do
        expect(ReleaseManager::Helpers::File).to receive(:create_dir).with(ReleaseManager::RELEASE_DIR)
        expect(ReleaseManager::Common::Cloner).to receive(:clone_agent)
        expect(ReleaseManager::Helpers::Git).to receive(:checkout).with('master')
      end
    end

    context 'components preparation' do
      let(:components) { [build(:component)] }

      before(:each) do
        allow(subject).to receive(:prep_agent)
      end

      after(:each) do
        subject.run
      end

      it 'clones the components and generates the diff' do
        expect(subject).to receive(:components_list).twice.and_return(components)
        expect(ReleaseManager::Common::Cloner).to receive(:clone_async).with(components)
        expect(ReleaseManager::ComponentsDiff::DiffGenerator).to receive(:generate).with(components.first)
        expect(subject).to receive(:fill_revision_field)
      end
    end
  end
end
