require 'mailpimp_mailer/member'
require 'mailpimp_mailer/customer'

module MailpimpMailer
  autoload :Member, 'mailpimp_mailer/member'
  autoload :Customer, 'mailpimp_mailer/customer'

  Gibbon::API.api_key = Mailpimp.mailservices['mailchimp']['api_key']
  Gibbon::API.timeout = 15
  Gibbon::API.throws_exceptions = false
  
  def self.connection(api_key = nil)
    Gibbon::API.new(api_key)
  end

end
