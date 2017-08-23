class ConfirmationsController < Devise::ConfirmationsController

  #######
  private
  #######

  def after_confirmation_path_for(resource_name, resource)
    insurance_apply_path(user: resource.id)
  end

end
