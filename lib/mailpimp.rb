require "mailpimp/engine"

module Mailpimp
  mattr_accessor :mailservices
  @@mailservices = nil

  def self.setup
    yield self
  end
end
