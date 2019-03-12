#! /usr/bin/ruby
# frozen_string_literal: true

require_relative '../lib/release_manager'
require_relative '../lib/components_diff/components_diff'

result = ReleaseManager::ComponentsDiff::Runner.run(ARGV[0] || 'master')
result.each do |component, details|
  puts "\n"
  puts "#{component} - #{details[:tag]}"
  details[:commits].each do |commit|
    puts '        ' + commit.delete("\n")
  end
end
