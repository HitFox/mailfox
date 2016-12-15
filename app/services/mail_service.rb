require 'mail_service/member'
require 'mail_service/customer'

module MailService
  autoload :List, 'mail_service/list'
  autoload :Member, 'mail_service/member'
  autoload :Customer, 'mail_service/customer'

  Gibbon::Request.api_key = Mailfox.mailservices['mailchimp']['api_key']
  Gibbon::Request.timeout = 15
  Gibbon::Request.throws_exceptions = false

  def self.connection(api_key = nil)
    Gibbon::Request.new(api_key: api_key)
  end
end
