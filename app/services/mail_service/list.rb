module MailService
  class List

    #
    # Concerns
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    include ActiveModel::Model

    #
    # Constants
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    #
    # Index
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    #
    # Attribute Settings
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    #
    # Validations
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #
            
    #
    # Callbacks
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    #
    # Constructor
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    #
    # Instance Methods
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    #
    # Class Methods
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    def self.exists?(id)
      find_by_id(id).present?
    end

    def self.find_by_id(id)
      return nil unless id

      response = fetch(filters: { list_id: id }).try(:with_indifferent_access)
      response[:data].try(:map, &:with_indifferent_access).try(:first) if response[:total] == 1
    end
  
    def self.all(options = {})
      fetch(options)[:data].try(:map, &:with_indifferent_access)
    end

    def self.count(options = {})
      fetch(options)[:total]
    end

    def self.fetch(options = {})
      begin
        parent.connection.lists.list(options).with_indifferent_access
      rescue => e  
        Rails.logger.info "**[MailService Error][Exists] #{e.message}"   
        Rails.logger.warn "**[MailService Error][Exists] #{e.backtrace.join("\n")}" if Rails.env.development?
        {}
      end
    end

    #
    # Protected Methods
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    protected

    #
    # Private Methods
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    private

  end
end
