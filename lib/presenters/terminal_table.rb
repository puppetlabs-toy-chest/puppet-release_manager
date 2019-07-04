module ReleaseManager
  module Presenters
    class TerminalTable
      def initialize(response)
        @response = response
        @rows     = []
      end

      def present
        generate_table
        display_table
      end

      private

      attr_reader :response, :rows

      def display_table
        puts ::Terminal::Table.new(
            headings: ['Component', 'Latest Tag', 'Suggested version', 'Reported Version', 'Maintenance Branch'],
            rows: rows
        )
      end

      def generate_table
        response.components.each do |component|
          next if ignore?(component)
          add_row(component)
        end
      end

      def ignore?(component)
        return true if /core|runtime|nssm|CFPropertyList|puppetlabs-scheduled_task/.match?(component.name)
        return true if /refs\/tags/.match?(component.ref)
        false
      end

      def add_row(component)
        rows << generate_row(component)
      end

      def generate_row(component)
        if version_change?(component)
          [component.name, component.tag.red, component.suggested_version.yellow, component.reported_version, component.branch.yellow]
        else
          [component.name, component.tag.green, component.suggested_version.green, component.reported_version, component.branch.yellow]
        end
      end

      def version_change?(component)
        component.tag != component.suggested_version
      end
    end
  end
end
