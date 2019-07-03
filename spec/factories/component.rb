# frozen_string_literal: true

FactoryBot.define do
  factory :component, class: ReleaseManager::Entities::Component do
    name      { 'test' }
    url       { 'test/url/test.git' }
    ref       { 'test_ref' }
    promoted  { true }
    path      { '' }

    initialize_with do
      new(
          name:     name,
          url:      url,
          ref:      ref,
          promoted: promoted,
          path:     path
      )
    end
  end
end
