# frozen_string_literal: true

describe ReleaseManager::Common::ComponentsReader do
  subject { build(:components_reader) }

  context 'interface' do
    it { is_expected.to respond_to(:components) }
  end

  context 'behaviour' do
    let(:facter) { subject.components.find { |component| component.name =~ /facter/ } }
    let(:runtime) { subject.components.find { |component| component.name =~ /puppet-runtime/ } }

    it 'correctly reads the components' do
      expect(facter).to be_a_kind_of(ReleaseManager::Entities::Component)
      expect(facter.name).to eq 'facter'
      expect(facter.ref).to eq 'refs/tags/3.14.0'
    end

    it 'correctly handles puppet runtime' do
      expect(runtime).to be_a_kind_of(ReleaseManager::Entities::Component)
      expect(runtime.name).to eq 'puppet-runtime'
      expect(runtime.url).to eq RUNTIME_URL
    end
  end
end
