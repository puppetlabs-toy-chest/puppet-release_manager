# frozen_string_literal: true

module ReleaseManager
  module Presenters
    class Terminal
      attr_reader :rows, :release_type, :branch

      def initialize(args = {})
        @branch = args[:branch]
        @release_type = args[:release_type]
        @rows = []
      end

      def present
        ComponentsDiff::Runner.run(branch).each do |component, details|
          print_details component, details
          next if /core|runtime|api/.match?(component)

          revision = details[:tag].match(/[0-9]+\.[0-9]+\.[0-9]+/)
          add_row(component, revision.to_s, details[:commits].any?)
        end
        puts ::Terminal::Table.new(
          headings: ['Component', 'Version', 'Suggested version'],
          rows: rows
        )
      end

      def change_version_z(revision)
        revision.gsub(/[0-9]+$/) { |s| (s.to_i + 1).to_s }
      end

      def change_version_y(revision)
        revision = revision.gsub(/\.[0-9]+\./) { |s| ".#{(s.delete('.').to_i + 1)}." }
        revision.gsub(/[0-9]+$/, '0')
      end

      private

      def print_details(component, details)
        puts "\n"
        puts "#{component} - #{details[:tag]}"
        details[:commits].each do |commit|
          puts "  #{commit.sha} - #{commit.message.delete("\n")}"
        end
      end

      def add_row(component, revision, changes_exist = false)
        rows << if changes_exist
                  change_version(component, revision)
                else
                  [component, revision.green, { value: revision.green, alignment: :center }]
                end
      end

      def change_version(component, revision)
        if !release_type || release_type == 'z'
          [component, revision.red, { value: change_version_z(revision).green, alignment: :center }]
        else
          [component, revision.red, { value: change_version_y(revision).green, alignment: :center }]
        end
      end
    end
  end
end
