# frozen_string_literal: true

describe ReleaseManager::Common::ComponentsResolver do
  context 'interface' do
    subject { build(:components_resolver) }

    it { is_expected.to respond_to(:create_component) }
  end

  context 'behaviour' do
    context 'when creating a valid component entity' do
      subject { build(:components_resolver).create_component }

      it 'resolves the component name' do
        expect(subject.name).to eq('from_url')
      end

      it 'resolves the component url' do
        expect(subject.url).to eq('test/url/from_url.git')
      end

      it 'resolves the component ref' do
        expect(subject.ref).to eq('test_ref')
      end

      it 'resolves whether the component is automatically promoted to PA' do
        expect(subject.promoted?).to eq(true)
      end
    end

    context 'when the component url is blank' do
      subject { build(:components_resolver, url: nil).create_component }

      it 'resolves the component name from the file name' do
        expect(subject.name).to eq('from_file_name')
      end
    end

    context 'when the component is not promoted' do
      it 'sets the promoted flag to false for resource_api' do
        component = build(:components_resolver, file_name: 'resource_api').create_component
        expect(component.promoted?).to be false
      end

      it 'sets the promoted flag to false for modules' do
        component = build(:components_resolver, file_name: 'module-puppetlabs').create_component
        expect(component.promoted?).to be false
      end
    end
  end
end
