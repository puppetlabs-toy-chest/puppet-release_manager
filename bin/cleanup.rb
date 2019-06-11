#! /usr/bin/ruby
# frozen_string_literal: true

require_relative '../lib/release_manager'

ReleaseManager::Helpers::File.delete_dir(RELEASE_DIR)
