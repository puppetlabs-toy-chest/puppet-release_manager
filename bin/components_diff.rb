#! /usr/bin/ruby
# frozen_string_literal: true

require_relative '../lib/release_manager'

request = ReleaseManager::ComponentsDiff::Request.new(
  source_branch: ARGV[0] || 'master',
  release_type: ARGV[1] || 'z'
)

response = ReleaseManager::Actions::Diff.new(request).run

ReleaseManager::Presenters::Terminal.new(response).present
