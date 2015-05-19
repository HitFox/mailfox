Mailpimp.setup do |config|

  config.mailservices = YAML.load_file("#{Rails.root}/config/settings.yml")
end
