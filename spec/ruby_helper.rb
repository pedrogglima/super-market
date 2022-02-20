# frozen_string_literal: true

require 'spec_helper'
require_relative './../super_market'

# Load helpers libs testing
Dir[File.join(__dir__, 'support', '*.rb')].sort.each do |f|
  require f
end

require 'byebug'
require 'factory_bot'

RSpec.configure do |config|
  config.include(FactoryBot::Syntax::Methods)

  config.before(:suite) do
    FactoryBot.find_definitions
  end
end
