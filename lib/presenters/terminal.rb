# frozen_string_literal: true

module ReleaseManager
  module Presenters
    class Terminal
      def initialize(response)
        @response = response
        @rows = []
      end

      def present
        response.components.each do |component|
          print_details(component)
          next if /core|runtime|nssm/.match?(component.name)

          add_row(component)
        end
        display_table
      end

      private

      attr_reader :response, :rows

      def print_details(component)
        puts "\n"
        puts "#{component.name} - #{component.tag}"
        component.commits.take(10).each { |commit| puts "  #{commit}" }
      end

      def add_row(component)
        rows << generate_row(component)
      end

      def generate_row(component)
        if version_change?(component)
          [component.name, component.tag.red, component.suggested_version.yellow, component.branch.yellow]
        else
          [component.name, component.tag.green, component.suggested_version.green, component.branch.yellow]
        end
      end

      def version_change?(component)
        component.tag != component.suggested_version
      end

      def display_table
        puts ::Terminal::Table.new(
          headings: ['Component', 'Version', 'Suggested version', 'Maintenance Branch'],
          rows: rows
        )
      end
    end
  end
end
