# frozen_string_literal: true

module ReleaseManager
  module Common
    class PromotionChanger
      FILE_PATH = CI_CONFIGS_DIR.join('jenkii', 'platform', 'projects', 'puppet-agent.yaml')

      def initialize(source_branch)
        @source_branch = source_branch
        @found   = false
        @branch  = source_branch.tr('.', '')
      end

      def change_promotion
        FileEditor.new(file_path: FILE_PATH).edit(&modify_promotion)
      end

      private

      attr_reader :source_branch

      def modify_promotion
        lambda do |line|
          if @found
            line = change_line(line)
            @found = false
          end
          @found = true if /&#{@branch}_agent_pe_promotion/.match?(line)
          line
        end
      end

      def change_line(line)
        return line.gsub('TRUE', 'FALSE') if /TRUE/.match?(line)

        line.gsub('FALSE', 'TRUE') if /FALSE/.match?(line)
      end

      def file_helper
        Helpers::File
      end
    end
  end
end
