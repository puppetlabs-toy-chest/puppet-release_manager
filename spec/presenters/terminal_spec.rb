# frozen_string_literal: true

describe ReleaseManager::Presenters::Terminal do
  subject { ReleaseManager::Presenters::Terminal.new(branch: 'master', release_type: 'z') }
  
  it { is_expected.to respond_to(:present) }
  it { is_expected.to respond_to(:rows) }
  it { is_expected.to respond_to(:change_version_z) }
  it { is_expected.to respond_to(:change_version_y) }

  context 'behaviour' do
    after(:each) do
      subject.present
    end

    it 'gets the required data' do
      expect(ReleaseManager::ComponentsDiff::Runner).to receive(:run).with('master').and_return([])
    end
  end

  context 'version management' do
    it 'chages the z version' do
      expect(subject.change_version_z('1.12.9')).to eq('1.12.10')
    end

    it 'chages the y version' do
      expect(subject.change_version_y('1.9.1')).to eq('1.10.0')
    end
  end
end


