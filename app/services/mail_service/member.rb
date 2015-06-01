module MailService
  class Member

    #
    # Concerns
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    extend ActiveModel::Translation

    include ActiveModel::Validations, ActiveModel::Conversion

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

    attr_accessor :email, :list_id, :locale
  
    attr_reader :connection, :subscriber_id, :double_optin
    
    alias_method :name, :email

    #
    # Validations
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    validates :email, :list_id, presence: true

    validates :email, email: true, allow_blank: true

    validate :uniqueness_of_email

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
  
    def initialize(attributes = {})
      defaults = {
        locale: I18n.locale,
        double_optin: true
      }
      
      attributes = defaults.merge(attributes).symbolize_keys

      @email = attributes[:email]
      @locale = attributes[:locale]
      @connection = self.class.parent.connection
      @double_optin = attributes[:double_optin]
      @list_id = attributes[:list_id]
      
      yield self if block_given?
    end

    #
    # Instance Methods
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    def list
      List.find_by_list_id(list_id) if list_id
    end

    def info
      begin
        unless @info
          response = connection.lists.member_info(id: list_id, emails: [{ email: email}]).with_indifferent_access
          @info = response[:data].first if response[:success_count] && response[:success_count] >= 1
        end
      rescue => e
        Rails.logger.info "**[MailService Error][Info] #{e.message}"
        Rails.logger.warn "**[MailService Error][Info] #{e.backtrace.join("\n")}" if Rails.env.development?
      end
      
      @info || {}
    end

    def persisted?
      false
    end

    def save
      return false unless valid?

      return true if Rails.env.test?

      begin
        connection.lists.subscribe(
          id: list_id, 
          email: { email: email },
          double_optin: double_optin,
          merge_vars: { mc_language: locale }
        )
      rescue => e
        Rails.logger.info "**[MailService Error][Save] #{e.message}"
        Rails.logger.warn "**[MailService Error][Save] #{e.backtrace.join("\n")}" if Rails.env.development?
        false
      end
    end

    def destroy
      begin
        connection.lists.unsubscribe(
          id: list_id, 
          email: { email: email }
        )
      rescue => e
        Rails.logger.info "**[MailService Error][Destroy] #{e.message}"
        Rails.logger.warn "**[MailService Error][Destroy] #{e.backtrace.join("\n")}" if Rails.env.development?
      end
    end

    def confirmed?
      info[:timestamp_opt].present?
    end

    def method_missing(method_name, *args, &block)
      if info.keys.include?(method_name.to_s)
        info[method_name]
      else
        super
      end
    end

    #
    # Class Methods
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    def self.create(attributes = {})
      mailservice = new(attributes)
      mailservice.save
      mailservice
    end

    def self.find_by_email(email)
      new(new(email: email).info.symbolize_keys)
    end

    def self.exists?(options = {})
      return false if options.blank?

      begin
        new(options.slice(:email, :list_id)).info.present?
      rescue => e  
        Rails.logger.info "**[MailService Error][Exists] #{e.message}"   
        Rails.logger.warn "**[MailService Error][Exists] #{e.backtrace.join("\n")}" if Rails.env.development?   
        e.message
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

    def uniqueness_of_email
      existence = self.class.exists?(email: email, list_id: list_id)

      case existence
        when TrueClass then errors.add(:email, :taken)
        when String then errors.add(:email, existence)
      end
    end

  end
end
