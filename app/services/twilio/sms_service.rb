module Twilio
  class SmsService
        def initialize(to:, pin:)
            @to = to
            @pin = pin
        end

        def send_otp
            account_sid = ENV['TWILIO_ACCOUNT_SID']
            auth_token = ENV['TWILIO_AUTH_TOKEN']
            from = ENV['PHONE_NUMBER']
            @client = Twilio::REST::Client.new(account_sid, auth_token)
            
            verification = @client.verify
                                    .v2
                                    .services('VAb537b912b9a1ab74173c98ac2c89fe60')
                                    .verifications
                                    .create(to: @to, channel: 'sms')
        end

        def verify_otp
            account_sid = ENV['TWILIO_ACCOUNT_SID']
            auth_token = ENV['TWILIO_AUTH_TOKEN']
            @client = Twilio::REST::Client.new(account_sid, auth_token)
            # phone_number = "+#{@to}"
            p '111111111111111111111111111'
            p @to
            verification_check = @client.verify
                            .v2
                            .services('VAb537b912b9a1ab74173c98ac2c89fe60')
                            .verification_checks
                            .create(to: @to, code: @pin)
            return  {status: verification_check.status}
        end
    end
    
end
