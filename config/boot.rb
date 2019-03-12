# frozen_string_literal: true

require 'pathname'
require 'json'
require 'pry'
require 'git'

ROOT_DIR = Pathname.new(File.expand_path('..', __dir__)) unless defined?(ROOT_DIR)
