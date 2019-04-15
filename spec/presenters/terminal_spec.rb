# frozen_string_literal: true

describe ReleaseManager::Presenters::Terminal do
  subject { ReleaseManager::Presenters::Terminal.new(branch: 'master', release_type: 'z') }
  
  it { is_expected.to respond_to(:present) }
  it { is_expected.to respond_to(:rows) }
  it { is_expected.to respond_to(:release_type) }
  it { is_expected.to respond_to(:branch) }

  context 'behaviour' do
    after(:each) do
      subject.present
    end

    it 'gets the required data' do
      expect(ReleaseManager::ComponentsDiff::Runner).to receive(:run).with('master', 'z').and_return([])
      expect(ReleaseManager::Helpers::File).to receive(:write)
    end
  end
end


