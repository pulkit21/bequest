class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  # protect_from_forgery prepend: true
  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?


  #########
  protected
  #########

  def render_404
    render file: Rails.root.join("public", "404"), layout: false, status: "404"
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :password, :password_confirmation, :address, :city, :state, :zipcode, :phone_number])
  end
end
