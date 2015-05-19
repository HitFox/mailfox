require "gibbon"
require "coffee-rails"
require "uglifier"
require "jquery-rails"
require "email_validator"

module Mailpimp
  class Engine < ::Rails::Engine
    isolate_namespace Mailpimp

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
