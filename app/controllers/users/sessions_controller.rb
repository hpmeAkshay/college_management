# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token

  def create
    user = User.find_by(email: params[:user][:email])
    if user && user.academic.present? && user.valid_password?(params[:user][:password])
      sign_in user
      token = request.env['warden-jwt_auth.token']
      render json: {
        id: user.id,
        is_academic_details_present: user.academic.present?,
        role: user.role,
        message: "Login Successfully",
        token: token 
      }
    else
      render json: { message: 'Login failed' }, status: 400
    end
  end
end
