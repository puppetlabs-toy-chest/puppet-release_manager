module ReleaseManager
  module Common
    class FileEditor
      def initialize(opts)
        @file_path = opts[:file_path]
      end

      def edit
        file_helper.open(file_path, 'r').each_line { |line| temp_file.puts(yield(line)) }
        replace
      end

      private

      attr_reader :file_path

      def file_helper
        Helpers::File
      end

      def temp_file
        @temp_file ||= file_helper.create_temporary_file
      end

      def replace
        temp_file.close
        file_helper.move_file(temp_file.path, file_path)
      end
    end
  end
end
