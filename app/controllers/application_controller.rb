class ApplicationController < ActionController::Base
    # before_action :configure_permitted_parameters, if: :devise_controller?
    
    # protected

    # def configure_permitted_parameters
    #     devise_parameter_sanitizer.permit(:sign_up, keys: [:data => [:type, :user => [:first_name, :last_name, :full_phone_number, :email, :gender, :role, :date_of_birth, :country, :city, :state, :address, :password, :password_confirmation]]])
    #     devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone_number, :email, :role, :profile_picture, :password, :password_confirmation])
    # end
      
end
