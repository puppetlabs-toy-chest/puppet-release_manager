# frozen_string_literal: true

module ReleaseManager
  module Repository
    module ComponentYamlStore
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
          result = file.map { |obj| YAML.safe_load(obj, [ReleaseManager::Entities::Component]) }
          file.close
          result
        end
      end
    end
  end
end
