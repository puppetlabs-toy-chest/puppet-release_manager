# frozen_string_literal: true

module ReleaseManager
  module ComponentsDiff; end
end

require_relative '../common/components_resolver'
require_relative '../common/cloner'
require_relative 'runner'
require_relative 'diff_generator'
