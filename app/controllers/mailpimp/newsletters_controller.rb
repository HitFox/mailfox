module Mailpimp
  class NewslettersController < Mailpimp::ApplicationController

  #
  # Settings
  # ---------------------------------------------------------------------------------------
  #
  #
  #
  #

  layout false

  #
  # Filter
  # ---------------------------------------------------------------------------------------
  #
  #
  #
  #

  #
  # Plugins
  # ---------------------------------------------------------------------------------------
  #
  #
  #
  #

  #
  # Actions
  # ---------------------------------------------------------------------------------------
  #
  #
  #
  #

  def create
    @customer = MailpimpMailer::Customer.new(permitted_params)

    respond_to do |format|
      if @customer.save
        format.js
      else
        format.js
      end
    end
  end

  #
  # Protected
  # ---------------------------------------------------------------------------------------
  #
  #
  #
  #

  protected

  #
  # Private
  # ---------------------------------------------------------------------------------------
  #
  #
  #
  #

  private

  def permitted_params
    params.require(:newsletter).permit(:email, :list_id)
  end

  end
end
