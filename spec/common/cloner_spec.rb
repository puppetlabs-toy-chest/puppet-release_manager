describe ReleaseManager::Common::Cloner do
  context 'interface' do
    subject { ReleaseManager::Common::Cloner }

    it { is_expected.to respond_to(:clone_component) }
    it { is_expected.to respond_to(:clone_agent) }
    it { is_expected.to respond_to(:clone_async) }
  end
end
