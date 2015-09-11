require "gibbon"
require "jquery-rails"
require "email_validator"

module Mailfox
  class Engine < ::Rails::Engine
    isolate_namespace Mailfox

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
