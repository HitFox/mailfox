require "mailpimp/engine"

module Mailpimp
  mattr_accessor :mailchimp
  @@mailchimp = nil

  def self.setup
    yield self
  end
end
