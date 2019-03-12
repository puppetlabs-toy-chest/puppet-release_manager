# frozen_string_literal: true

module ReleaseManager
  module ComponentsDiff
    module ComponentsResolver
      class << self
        def each_component
          return unless block_given?

          Helpers::File.each_file(AGENT_DIR.join('configs', 'components', '*.json')) do |file_name|
            json = JSON.parse(Helpers::File.read(file_name))
            yield(
              resolve_name(file_name, json['url']),
              json['url'],
              json['ref'],
              module?(file_name)
            )
          end
        end

        private

        def module?(file_name)
          /module-puppetlabs/.match?(file_name)
        end

        def resolve_name(file_name, url)
          return json_name_to_component_name(file_name) if url.nil?

          url_to_component_name(url)
        end

        # Calculate name of repository from the .git URL.
        def url_to_component_name(url)
          url.split('/').last.split('.').first
        end

        # Calculate name of repository from the name of the component's .json file.
        def json_name_to_component_name(json_filename)
          json_filename.split('/').last.split('.').first
        end
      end
    end
  end
end
