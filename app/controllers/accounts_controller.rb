class AccountsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def sms_confirmation
      sms_service = Twilio::SmsService.new(to: current_user.full_phone_number, pin: sms_verification_params[:pin])
      verification_check = sms_service.verify_otp
      render json: verification_check
    end
  
    private
  
    def sms_verification_params
      params.require(:data).permit(:pin)
    end
end
  