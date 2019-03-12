# frozen_string_literal: true

require_relative '../config/boot'
require_relative 'helpers/file'
require_relative 'helpers/git'

module ReleaseManager
  RELEASE_DIR    = ROOT_DIR.join('new_release')
  AGENT_URL      = 'git@github.com:puppetlabs/puppet-agent.git'
  COMPONENTS_DIR = RELEASE_DIR.join('pkg')
  AGENT_DIR      = RELEASE_DIR.join('puppet-agent')
end
