# frozen_string_literal: true

module ReleaseManager
  module Entities
    class Bumper
      attr_reader :name, :path, :branch, :version

      def self.create(args = {})
        new(args)
      end

      def initialize(args = {})
        @name      = args[:name]
        @path      = args[:path]
        @branch    = args[:branch]
        @version   = args[:version]
      end
    end
  end
end
