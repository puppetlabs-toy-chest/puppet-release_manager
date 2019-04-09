#! /usr/bin/ruby
# frozen_string_literal: true

require_relative '../lib/release_manager'
require_relative '../lib/components_diff/components_diff'
require_relative '../lib/presenters/terminal'

unless ARGV[0]
  puts 'Please provide branch, it is mandatory!'
  return
end
ReleaseManager::Presenters::Terminal.new(branch: ARGV[0], release_type: ARGV[1]).present
