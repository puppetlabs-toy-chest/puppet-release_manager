# frozen_string_literal: true

require 'factory_bot'
require_relative '../lib/release_manager'
require_relative '../lib/components_diff/components_diff'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end
end
