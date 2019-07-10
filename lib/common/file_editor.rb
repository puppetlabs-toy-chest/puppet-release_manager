# frozen_string_literal: true

module ReleaseManager
  module Common
    class FileEditor
      def initialize(opts)
        @file_path = opts[:file_path]
      end

      def edit
        file_helper.each_line(file_path) { |line| temp_file.puts(yield(line)) }
        replace_file
      end

      private

      attr_reader :file_path

      def file_helper
        Helpers::File
      end

      def temp_file
        @temp_file ||= file_helper.create_temporary_file
      end

      def replace_file
        temp_file.close
        file_helper.move_file(temp_file.path, file_path)
      end
    end
  end
end
