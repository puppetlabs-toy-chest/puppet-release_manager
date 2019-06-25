# frozen_string_literal: true

module ReleaseManager
  module Helpers
    module File
      class << self
        def delete_dir(path)
          FileUtils.remove_dir(path) if dir_exists?(path)
        end

        def create_dir(path)
          FileUtils.mkdir_p(path) unless dir_exists?(path)
        end

        def read_dir(dir_path)
          Dir.glob(dir_path)
        end

        def read(file)
          ::File.read(file)
        end

        def dir_exists?(path)
          Dir.exist?(path)
        end

        def write(file, hash)
          ::File.write(file, hash)
        end
        
        def each_line(file_path, &block)
          ::File.foreach(file_path, "\n", &block)
        end

        def create_temporary_file(name = 'tmpfile')
          Tempfile.new(name)
        end

        def open(file_path, mode)
          ::File.open(file_path, mode)
        end

        def move_file(source_path, dest_path)
          FileUtils.mv(source_path, dest_path)
        end
      end
    end
  end
end
