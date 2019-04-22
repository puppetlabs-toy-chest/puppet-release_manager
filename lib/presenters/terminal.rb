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
        to_write = []
        ComponentsDiff::Runner.run(branch, release_type).each do |component, details|
          print_details(component, details)
          next if /core|runtime|api/.match?(component)

          add_row(component, details)
          to_write << { components: component, version: details[:suggested] }
        end
        Helpers::File.write(VERSIONS_FILE, to_write.to_yaml)
        display_table
      end

      private

      def print_details(component, details)
        puts "\n"
        puts "#{component} - #{details[:tag]}"
        details[:commits].each do |commit|
          puts "  #{commit.sha} - #{commit.message.delete("\n")}"
        end
      end

      def add_row(component, details)
        rows << if details[:commits].any?
                  [component, details[:current_version].red, details[:suggested].yellow]
                else
                  [component, details[:current_version].green, details[:suggested].green]
                end
      end

      def display_table
        puts ::Terminal::Table.new(
          headings: ['Component', 'Version', 'Suggested version'],
          rows: rows
        )
      end
    end
  end
end
