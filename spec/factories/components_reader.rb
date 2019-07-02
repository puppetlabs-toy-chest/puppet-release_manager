# frozen_string_literal: true

FactoryBot.define do
  factory :components_reader, class: ReleaseManager::Common::ComponentsReader do
    components_stub_dir { ROOT_DIR.join('spec', 'fixtures', 'components', '*.json') }

    initialize_with do
      new(ReleaseManager::Helpers::File.read_dir(components_stub_dir))
    end
  end
end
