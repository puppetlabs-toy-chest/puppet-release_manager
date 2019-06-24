# frozen_string_literal: true

require 'pathname'
require 'json'
require 'pry'
require 'git'
require 'logger'
require 'terminal-table'
require 'colorize'
require 'yaml'
require 'ostruct'

ROOT_DIR = Pathname.new(File.expand_path('..', __dir__)) unless defined?(ROOT_DIR)

RELEASE_DIR    = ROOT_DIR.join('new_release')
AGENT_URL      = 'git@github.com:puppetlabs/puppet-agent.git'
RUNTIME_URL    = 'git@github.com:puppetlabs/puppet-runtime.git'
COMPONENTS_DIR = RELEASE_DIR.join('pkg')
AGENT_DIR      = RELEASE_DIR.join('puppet-agent')
RUNTIME_DIR    = COMPONENTS_DIR.join('puppet-runtime')
LOG_DIR        = ROOT_DIR.join('log')
VERSIONS_FILE  = ROOT_DIR.join('config', 'current_release_versions.yaml')
TMP_DIR        = RELEASE_DIR.join('tmp')

def load_files(*dirs)
  dirs.each do |dir|
    Dir[ROOT_DIR.join(dir)].each { |f| require f }
  end
end

load_files(
  'lib/common/*.rb',
  'lib/helpers/*.rb',
  'lib/entities/*.rb',
  'lib/factories/*.rb',
  'lib/actions/*.rb',
  'lib/components_diff/*.rb',
  'lib/repository/*.rb',
  'lib/presenters/*.rb',
  'lib/version_handler/*.rb'
)
