module MailService
  class Member

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

    attr_reader :connection, :list_id, :email_address

    #
    # Validations
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    validates :email_address, :list_id, presence: true

    validates :email_address, email: true, allow_blank: true

    validate :uniqueness_of_email, on: :create

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

    def initialize(attributes = {}, log = false)
      @log = log
      @attributes = attributes.symbolize_keys

      @email_address = @attributes[:email_address]
      @connection = self.class.parent.connection
      @list_id = @attributes[:list_id]

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

    def save
      return false unless valid?(:create)
      return true if Rails.env.test?

      begin
        connection.lists(list_id).members.create({ body: transformAttributes })
      rescue => e
        log_error(e)
        false
      end
    end

    def update
      return false unless valid?(:update)
      return true if Rails.env.test?

      begin
        connection.lists(list_id).members(email_hashed).upsert({ body: transformAttributes })
      rescue => e
        log_error(e)
        false
      end
    end

    def destroy
      begin
        connection.lists(list_id).members(email_hashed).update(body: { status: "unsubscribed" })
      rescue => e
        log_error(e)
        false
      end
    end

    def confirmed?
      fetch.try(:[], 'status') == 'subscribed'
    end

    def fetch(options = {})
      return @fetch if @fetch

      begin
        @fetch = connection.lists(list_id).members(email_hashed).retrieve(params: options).with_indifferent_access
        @fetch
      rescue => e
        log_error(e)
        nil
      end
    end

    #
    # Class Methods
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    def self.create(attributes = {}, log = false)
      mailservice = new(attributes, log)
      mailservice.save
      mailservice
    end

    def self.update(attributes = {}, log = false)
      mailservice = new(attributes, log)
      mailservice.update
      mailservice
    end

    def self.find_by_email(list_id, email, options = {}, log = false)
      new({ list_id: list_id, email_address: email }, log).fetch(options)
    end

    def persisted?
      false
    end

    def self.exists?(list_id, email, options = {})
      return false if !defined?(list_id) || !defined?(email)

      member = find_by_email(list_id, email)
      return member ? true : false
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

    def log_error(e)
      return unless @log

      Rails.logger.info "**[MailService Error][Info] #{e.message}"
      Rails.logger.warn "**[MailService Error][Info] #{e.backtrace.join("\n")}" if Rails.env.development?
    end

    # we need to prepare(transform) the attributes to be in the correct format
    def transformAttributes
      defaults = {
        language: I18n.locale,
        status: 'pending' # possible states: 'subscribed', 'unsubscribed', 'cleaned', 'pending'
      }
      attrs = defaults.merge(@attributes)

      if attrs[:interests]
        attrs[:interests] = attrs[:interests].split(',').map{ |interest| [interest, true] }.to_h
      end

      attrs.reject { |key, value| value.nil? }
    end

    def email_hashed
      Digest::MD5.hexdigest(email_address.to_s.downcase)
    end

    def uniqueness_of_email
      existence = self.class.exists?(list_id, email_address)

      case existence
      when TrueClass then errors.add(:email_address, :taken)
      when String then errors.add(:email_address, existence)
      end
    end

  end
end
