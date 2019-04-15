# frozen_string_literal: true

describe ReleaseManager::Common::VersionHandler do
  subject { build(:version_handler) }

    it { is_expected.to respond_to(:should_add_versions?) }
    it { is_expected.to respond_to(:change_version) }
    it { is_expected.to respond_to(:add_versions) }

  context 'version management with x release type' do
    it 'changes version' do
      expect(subject.change_version).to eq('1.9.10')
    end
  end

  context 'version management with y release type' do
    subject { build(:version_handler, release_type: 'y') }

    it 'changes version' do
      expect(subject.change_version).to eq('1.10.0')
    end
  end

  context 'component picking' do
    it 'ignores component' do
      expect(subject.should_add_versions?).to eq(false)
    end
  end


  context 'component picking' do
    subject { build(:version_handler, name: 'puppet_runtime') }

    it 'proccesses component' do
      expect(subject.should_add_versions?).to eq(true)
    end
  end
end
