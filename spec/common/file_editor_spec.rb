# frozen_string_literal: true

describe ReleaseManager::Common::FileEditor do
  subject { ReleaseManager::Common::FileEditor.new({file_path: path}) }
  let(:path) { ROOT_DIR.join('spec', 'fixtures', 'file_editor_test') }

  context 'interface' do
    it { is_expected.to respond_to(:edit) }
  end

  context 'behaviour' do
    let(:regex) { ->(line) { line.gsub('TRUE', 'FALSE') if /TRUE/.match?(line) } }

    before { ReleaseManager::Helpers::File.write(path,'ALWAYS TRUE') }

    # cleanup
    after { ReleaseManager::Helpers::File.delete(path) }

    it 'changes the content of a file' do
      subject.edit(&regex)
      expect(ReleaseManager::Helpers::File.read(path)).to eq("ALWAYS FALSE\n")
    end
  end
end
