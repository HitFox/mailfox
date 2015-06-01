require 'mail_service/member'
require 'mail_service/customer'

module MailService
  autoload :Member, 'mail_service/member'
  autoload :Customer, 'mail_service/customer'

  Gibbon::API.api_key = Mailpimp.mailservices['mailchimp']['api_key']
  Gibbon::API.timeout = 15
  Gibbon::API.throws_exceptions = false
  
  def self.connection(api_key = nil)
    Gibbon::API.new(api_key)
  end

end
