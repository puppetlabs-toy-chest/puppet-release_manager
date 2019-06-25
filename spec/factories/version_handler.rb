# frozen_string_literal: true

FactoryBot.define do
  factory :version_handler, class: ReleaseManager::VersionHandler do
    component     { {tag: 'No URL provided.', commits: [], current_version: '1.9.9'} }
    release_type  { 'z' }
    name          { 'pxp-agent' }

    initialize_with do
      new(
          component: component,
          release_type: release_type,
          name: name
      )
    end
  end
end