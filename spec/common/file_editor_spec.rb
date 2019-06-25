# frozen_string_literal: true

describe ReleaseManager::Common::FileEditor do
  let(:path) {ROOT_DIR.join('spec', 'fixtures', 'file_editor_test')}
  subject { ReleaseManager::Common::FileEditor.new({file_path: path}) }
  context 'interface' do


    it { is_expected.to respond_to(:edit) }
  end
  context 'behaviour' do
    let(:regex) {lambda do |line| line.gsub('TRUE', 'FALSE') if /TRUE/.match?(line) end}

    after(:each) do
      ReleaseManager::Helpers::File.open(path, 'w')
    end

    it 'change the content of a file' do
      ReleaseManager::Helpers::File.write(path,'ALWAYS TRUE')
      subject.edit(&regex)
      expect(ReleaseManager::Helpers::File.read(path)).to eq("ALWAYS FALSE\n")
    end
  end
end
