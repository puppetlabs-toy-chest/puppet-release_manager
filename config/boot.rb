# frozen_string_literal: true

require 'pathname'
require 'json'
require 'pry'
require 'git'
require 'logger'
require 'terminal-table'
require 'colorize'

ROOT_DIR = Pathname.new(File.expand_path('..', __dir__)) unless defined?(ROOT_DIR)
