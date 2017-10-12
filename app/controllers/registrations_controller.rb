class RegistrationsController < Devise::RegistrationsController
  before_action :set_header_footer, only: []

  #########
  protected
  #########

  def set_header_footer
    @header_footer_on = true
  end

  def after_inactive_sign_up_path_for(resource)
    if resource.active_zipcode?
      confirm_email_path
    else
      insurance_coming_soon_path
    end
  end

end
