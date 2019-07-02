# frozen_string_literal: true

FactoryBot.define do
  factory :version_bumper, class: ReleaseManager::VersionHandler::VersionBumper do
    release_type  { 'z' }
    current_version { '9.9.9' }

    initialize_with do
      new(
        release_type:   release_type,
        current_version: current_version
      )
    end
  end
end