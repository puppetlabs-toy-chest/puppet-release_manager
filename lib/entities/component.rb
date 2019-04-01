# frozen_string_literal: true

module ReleaseManager
  module Entities
    class Component
      attr_reader :name, :url, :ref, :promoted

      def self.create(args = {})
        new(args)
      end

      def initialize(args = {})
        @name      = args[:name]
        @url       = args[:url]
        @ref       = args[:ref]
        @promoted  = args[:promoted]
      end

      alias promoted? promoted
    end
  end
end
