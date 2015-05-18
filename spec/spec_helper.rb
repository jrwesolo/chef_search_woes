require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.formatter = 'documentation'
  config.color = true

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

ChefSpec::Coverage.start!
