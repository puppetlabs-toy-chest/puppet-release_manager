# frozen_string_literal: true

require_relative '../lib/release_manager'

request = OpenStruct.new(
  source_branch: ARGV[0] || 'master'
)

ReleaseManager::Actions::Initializer.new(request).run
