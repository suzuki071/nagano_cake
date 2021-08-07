class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :telephone_number])
  end
  
  # def after_sign_up_path_for(resource)
  #   case resource
  #   when Customer
  #     customer_path(current_customer)
  #   when Admin
  #     admin_orders_path
  #   end
  # end

  # def after_sign_in_path_for(resource)
  #   case resource
  #   when Customer
  #     customer_path(current_customer)
  #   when Admin
  #     admin_orders_path
  #   end
  # end

  def after_sign_out_path_for(resource)
    if Customer
      top_path
    else
      new_admin_session_path
    end
  end

end
