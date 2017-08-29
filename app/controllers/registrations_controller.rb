class RegistrationsController < Devise::RegistrationsController
  before_action :set_header_footer, only: []

  #########
  protected
  #########

  def set_header_footer
    @header_footer_on = true
  end

  def after_inactive_sign_up_path_for(resource)
    confirm_email_path
  end
  
end
