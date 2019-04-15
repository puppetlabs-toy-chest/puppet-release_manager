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
      end
    end
  end
end
