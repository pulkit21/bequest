class RegistrationsController < Devise::RegistrationsController

  #########
  protected
  #########

  def after_inactive_sign_up_path_for(resource)
    confirm_email_path
  end
end
