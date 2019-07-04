# frozen_string_literal: true

module ReleaseManager
  module Presenters
    class Terminal
      def initialize(response)
        @response = response
      end

      def present
        response.components.each { |component| print_details(component) }
      end

      private

      attr_reader :response, :rows

      def print_details(component)
        puts "\n"
        component.promoted ? extra = '' : extra = '(not promoted)'
        puts "#{component.name} - #{component.tag} #{extra}"
        component.commits.take(10).each { |commit| puts "  #{commit}" }
      end
    end
  end
end
