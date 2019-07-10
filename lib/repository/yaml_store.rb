# frozen_string_literal: true

module ReleaseManager
  module Repository
    module YamlStore
      STORE_FILE = TMP_DIR.join('store.yaml')

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
          result = file.map { |obj| YAML.safe_load(obj, permitted) }
          file.close
          result
        end

        private

        def permitted
          [ReleaseManager::Entities::Component, ReleaseManager::Entities::Bumper, Pathname]
        end
      end
    end
  end
end
