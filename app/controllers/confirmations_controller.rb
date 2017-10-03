class ConfirmationsController < Devise::ConfirmationsController

  #######
  private
  #######

  def after_confirmation_path_for(resource_name, resource)
    insurance_product_path(user: resource.id)
  end

end
