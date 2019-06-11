# frozen_string_literal: true

module ReleaseManager
  module Common
    class MultiLogger
      LEVELS = %i[debug info warn error fatal unknown].freeze

      LEVELS.each do |m|
        define_method(m) do |*args|
          targets.map { |t| t.send(m, *args) }
        end
      end

      def initialize(*targets)
        @targets = targets
      end

      private

      attr_reader :targets
    end
  end
end
