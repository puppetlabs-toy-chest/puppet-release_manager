# frozen_string_literal: true

FactoryBot.define do
  factory :components_resolver, class: ReleaseManager::Common::ComponentsReader do
    file_name { 'from_file_name.json' }
    url       { 'test/url/from_url.git' }
    ref       { 'test_ref' }

    initialize_with do
      new(
        file_name: file_name,
        url: url,
        ref: ref
      )
    end
  end
end
