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

      response = fetch({ list_id: id })
    end

    def self.all(options = {})
      fetch(options)[:lists]
    end

    def self.count(options = {})
      fetch(options)[:total_items]
    end

    def self.fetch(options = {})
      begin
        id = nil
        if options[:list_id]
          id = options[:list_id]
          options.delete(:list_id)
        end

        parent.connection.lists(id).retrieve(params: options).with_indifferent_access
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
