# frozen_string_literal: true

require_relative '../config/boot'
require_relative 'helpers/file'
require_relative 'helpers/git'
require_relative 'helpers/jira'
require_relative 'entities/component'
require_relative 'common/version_handler'

module ReleaseManager
  RELEASE_DIR    = ROOT_DIR.join('new_release')
  AGENT_URL      = 'git@github.com:puppetlabs/puppet-agent.git'
  COMPONENTS_DIR = RELEASE_DIR.join('pkg')
  AGENT_DIR      = RELEASE_DIR.join('puppet-agent')
  LOG_DIR        = ROOT_DIR.join('log')
  VERSIONS_FILE  = ROOT_DIR.join('config', 'current_release_versions.yaml')

  def self.logger
    return @logger unless @logger.nil?

    Helpers::File.create_dir(LOG_DIR) unless Helpers::File.dir_exists?(LOG_DIR)
    @logger = Logger.new(File.open(LOG_DIR.join('release_manager.log'), 'a'))
  end
end
