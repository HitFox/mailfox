require "mailfox/engine"

module Mailfox
  mattr_accessor :mailservices
  @@mailservices = nil

  def self.setup
    yield self
  end
end
