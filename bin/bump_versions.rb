# frozen_string_literal: true

require_relative '../lib/release_manager'

request = OpenStruct.new # to keep the resemblance of an interface
ReleaseManager::Actions::VersionBumper.new(request).run_async
