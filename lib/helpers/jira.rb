# frozen_string_literal: true

module ReleaseManager
  module Helpers
    class Jira
      def call
        # base_query = 'project = PUP'
        #
        # jira_data = {
        #   jql: base_query,
        #   maxResults: 5,
        #   fields: %w[issuetype status customfield_14200 customfield_11100 customfield_12100]
        # }
        #
        # jira_post_data = JSON.fast_generate(jira_data)
        #
        # result = JSON.parse(`curl -X POST -H 'Content-Type: application/json' --data
        # '#{jira_post_data}' https://tickets.puppetlabs.com/rest/api/2/search`)
      end
    end
  end
end
