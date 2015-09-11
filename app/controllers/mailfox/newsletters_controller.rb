module Mailfox
  class NewslettersController < Mailfox::ApplicationController

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
    @customer = MailService::Customer.create(permitted_params)

    respond_to do |format|
      format.js
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
