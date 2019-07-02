describe ReleaseManager::VersionHandler::VersionBumper do
  subject { build(:version_bumper) }

  context 'interface' do
    it { is_expected.to respond_to(:increment_version) }
  end

  context 'behaviour' do
    context 'for z versions' do
      it 'correctly increments the version' do
        expect(subject.increment_version).to eq '9.9.10'
      end
    end

    context 'for y versions' do
      subject { build(:version_bumper, release_type: 'y') }

      it 'correctly increments the version' do
        expect(subject.increment_version).to eq '9.10.0'
      end
    end

    context 'for x versions' do
      subject { build(:version_bumper, release_type: 'x') }

      it 'correctly increments the version' do
        expect(subject.increment_version).to eq '10.0.0'
      end
    end
  end
end
