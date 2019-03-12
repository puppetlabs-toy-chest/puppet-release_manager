#! /usr/bin/ruby
# frozen_string_literal: true

require_relative '../lib/release_manager'
require_relative '../lib/components_diff/components_diff'

result = ReleaseManager::ComponentsDiff::Runner.run(ARGV[0] || 'master')
result.each do |component, details|
  puts "#{component} - #{details[:tag]}"
  puts details[:commits]
  puts "\n\n"
end
