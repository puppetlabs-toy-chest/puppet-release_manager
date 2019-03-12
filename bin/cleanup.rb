#! /usr/bin/ruby
# frozen_string_literal: true

require_relative '../lib/release_manager'
require_relative '../lib/helpers/file'

ReleaseManager::Helpers::File.delete_dir(ReleaseManager::RELEASE_DIR)
