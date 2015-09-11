module Mailfox
  module ApplicationHelper
    def error_messages_for(object, options = {})
      messages = options[:length] ? [object.errors.full_messages[options[:length] - 1]] : object.errors.full_messages
      
      content_tag :ul, class: 'error-messages' do
        messages.each do |msg|
          concat content_tag(:li, msg)
        end
      end
    end
  end
end
