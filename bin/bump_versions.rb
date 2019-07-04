# frozen_string_literal: true

require_relative '../lib/release_manager'

request = OpenStruct.new
ReleaseManager::Actions::VersionBumper.new(request).run
