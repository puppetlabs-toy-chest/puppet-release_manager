# frozen_string_literal: true

module ReleaseManager
  module Repository
    module BumperYamlStore
      STORE_FILE = TMP_DIR.join('components_to_bump.yaml')

      class << self
        def save(entities)
          file = File.open(STORE_FILE, 'w+')
          entities.each do |entity|
            file.puts YAML.dump(entity)
            file.puts ''
          end
          file.close
        end

        def read
          $/ = "\n\n"
          file = File.open(STORE_FILE, 'r')
          result = file.map { |obj| YAML.safe_load(obj, [ReleaseManager::Entities::Bumper, Pathname]) }
          file.close
          result
        end
      end
    end
  end
end
