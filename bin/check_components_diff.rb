#! /usr/bin/ruby
# frozen_string_literal: true

require_relative '../lib/release_manager'
require_relative '../lib/components_diff/components_diff'
require 'terminal-table'
require 'colorize'

class Presenter
  attr_reader :rows

  def initialize
    @rows = []
  end

  def present
    ReleaseManager::ComponentsDiff::Runner.run(ARGV[0] || 'master').each do |component, details|
      print_details component, details
      next if /core|runtime|api/.match?(component)

      add_row component, details[:tag], details[:commits].any?
    end
    puts Terminal::Table.new rows: rows
  end

  private

  def print_details(component, details)
    puts "\n"
    puts "#{component} - #{details[:tag]}"
    details[:commits].each do |commit|
      puts "  #{commit.sha} - #{commit.message.delete("\n")}"
    end
  end

  def add_row(component, tag, changes_exist = false)
    revision = tag.match(/[0-9]+\.[0-9]+\.[0-9]+/)
    rows << if changes_exist
              [component, revision.to_s.green, nil]
            else
              [component, revision.to_s.red, (change_revision revision.to_s).green]
            end
  end

  def change_revision(revision)
    revision.gsub(/[0-9]+$/) { |s| (s.to_i + 1).to_s }
  end
end

Presenter.new.present
