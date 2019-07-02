describe ReleaseManager::Common::PromotionChanger do
  subject { build(:promotion_changer) }

  context 'interface' do
    it { is_expected.to respond_to(:change_promotion) }
  end

  context 'behaviour' do
    let(:file_to_change) { ROOT_DIR.join('spec', 'fixtures', 'promotion_changer', 'puppet_agent.yaml') }
    let!(:old_contents) { File.read(file_to_change) }

    before do
      stub_const('ReleaseManager::Common::PromotionChanger::FILE_PATH', file_to_change)
    end

    after { File.write(file_to_change, old_contents) }

    context 'for master' do
      let(:expected_file) { ROOT_DIR.join('spec', 'fixtures', 'promotion_changer', 'master_disabled.yaml') }

      before { subject.change_promotion }

      it 'correctly disables pe promotion' do
        expect(FileUtils.compare_file(file_to_change, expected_file)).to be_truthy
      end
    end

    context 'for 6.4.x' do
      subject { build(:promotion_changer, source_branch: '6.4.x') }
      let(:expected_file) { ROOT_DIR.join('spec', 'fixtures', 'promotion_changer', '64x_disabled.yaml') }

      before { subject.change_promotion }

      it 'correctly disables pe promotion' do
        expect(FileUtils.compare_file(file_to_change, expected_file)).to be_truthy
      end
    end

    context 'for 6.0.x' do
      subject { build(:promotion_changer, source_branch: '6.0.x') }
      let(:expected_file) { ROOT_DIR.join('spec', 'fixtures', 'promotion_changer', '60x_disabled.yaml') }

      before { subject.change_promotion }

      it 'correctly disables pe promotion' do
        expect(FileUtils.compare_file(file_to_change, expected_file)).to be_truthy
      end
    end

    context 'for 5.5.x' do
      subject { build(:promotion_changer, source_branch: '5.5.x') }
      let(:expected_file) { ROOT_DIR.join('spec', 'fixtures', 'promotion_changer', '55x_disabled.yaml') }

      before { subject.change_promotion }

      it 'correctly disables pe promotion' do
        expect(FileUtils.compare_file(file_to_change, expected_file)).to be_truthy
      end
    end
  end
end
