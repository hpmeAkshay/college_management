class Users::RegistrationsController < Devise::RegistrationsController
  
  skip_before_action :verify_authenticity_token

  def create
    if params[:data] && params[:data][:type] == "sms_account"
      build_resource(sign_up_params)
      resource.save
      if resource.persisted?
        # Twilio::SmsService.new(to: resource.full_phone_number, pin: '').send_otp
        sign_up(resource_name, resource)
        token = request.env['warden-jwt_auth.token']
        response_data = {
          response: {
            id: resource.id,
            type: "sms_otp",
            token: token,
            message: "Account is created successfully and otp sent to the phone number"
          }
        }
        render json: response_data
      else
        existing_user = User.find_by(email: resource.email)
        if  existing_user
          if existing_user.academic.present?
            response = {
              data: { 
                id: existing_user.id, 
                type: "sms_otp", 
                meta: { token: token }, 
                errors: {account: "Account already exists"}
              }
            }
            render  status: 200, json: response 
          else
            existing_user.full_phone_number = params[:data][:user][:full_phone_number]
            token = existing_user.generate_jwt
            # Twilio::SmsService.new(to:existing_user.full_phone_number, pin: '').send_otp
            response = {
              response: { 
                id: existing_user.id, 
                type: "sms_otp", 
                token: token , 
                message: "Account already exists, Verification code has been sent on your phone number, Please verify your phone number number to activate your account"
              }
            }
            render  status: 200, json: response 
          end
        else
          render json: {errors: resource.errors.full_messages}, status: 422
        end
      end
    else
      render json: { status: { code: 400, message: "Invalid account type" } }
    end
  end

  private

  def sign_up_params
    params.require(:data).require(:user).permit(:first_name, :last_name, :full_phone_number, :email, :gender, :role, :date_of_birth, :country, :city, :state, :address, :password, :password_confirmation)
  end
end
