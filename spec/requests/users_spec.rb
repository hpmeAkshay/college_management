require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /users" do
    context 'With valid params' do
      let(:valid_params) do
        {
          data: {
            type: 'sms_account',
            user: FactoryBot.attributes_for(:user)
          }
        }
      end
      
      it 'creates a new user' do
        expect {
          post '/users', params: valid_params
        }.to change(User, :count).by(1)
      end

      it 'creates a new user and send otp on the provided phone number' do
        post '/users', params: valid_params
        expect(response).to have_http_status(200)
        response_json = JSON.parse(response.body)
        expect(response_json['response']['message']).to eq("Account is created successfully and otp sent to the phone number")
      end

    end
 
    context 'With existing account'  do
      
      let(:valid_params) do
        {
          data: {
            type: 'sms_account',
            user:{
              email: 'user2@example.com',
              password: Faker::Internet.password,
              first_name: Faker::Name.first_name ,
              last_name:  Faker::Name.last_name ,
              full_phone_number:  '+918805463425', 
              gender:  Faker::Gender.binary_type ,
              role:  'student' ,
              date_of_birth:  Faker::Date.birthday(min_age: 18, max_age: 65).strftime("%d/%m/%Y") ,
              country:  Faker::Address.country ,
              city:  Faker::Address.city ,
              state:  Faker::Address.state, 
              address:  Faker::Address.street_address 
          }
          }
        }
      end

      it 'does not create a new account for existing one, but sends an otp on provided phone number for account activation' do
        post '/users', params: valid_params
        expect(response).to have_http_status(200)

        # Send the same params again
        post '/users', params: valid_params
        expect(response).to have_http_status(200)
        response_json = JSON.parse(response.body)
        expect(response_json['response']['message']).to eq("Account already exists, Verification code has been sent on your phone number, Please verify your phone number number to activate your account")
      end
    end
 
    context 'With existing account with academic'  do
      let(:user) { FactoryBot.create(:user) }
      let(:interest) { FactoryBot.create(:interest) }
      let(:qualification) { FactoryBot.create(:qualification) }
    
      let(:valid_params) do
        {
          academic: FactoryBot.attributes_for(
            :academic,
            user_id: user.id,
            interest_id: interest.id,
            qualification_id: qualification.id
          )
        }
      end

      it 'does not creates an account and does not send an otp' do
        post '/academics', params: valid_params[:academic]
        expect(response).to have_http_status(201)
        post '/users', params: { data:
          {
            type: "sms_account",
            user: {
              first_name: user.first_name,
              last_name: user.last_name,
              email: user.email,
              full_phone_number: user.full_phone_number,
              date_of_birth: user.date_of_birth,
              role: user.role,
              city: user.city,
              state: user.state,
              country: user.country,
              address: user.state,
              state: user.password
            }
          }
        }
        expect(response).to have_http_status(200)
      end


    end

    context 'With invalid params' do
      let(:invalid_params) do
        {
          user: {
            email: '',
            encrypted_password: Faker::Internet.password,
            first_name: Faker::Name.first_name ,
            last_name:  Faker::Name.last_name ,
            full_phone_number:  Faker::PhoneNumber.phone_number, 
            gender:  Faker::Gender.binary_type ,
            role:  'student' ,
            date_of_birth:  Faker::Date.birthday(min_age: 18, max_age: 65).strftime("%d/%m/%Y") ,
            country:  Faker::Address.country ,
            city:  Faker::Address.city ,
            state:  Faker::Address.state, 
            address:  Faker::Address.street_address 
          }
        }
      end

      it 'does not create a new user with null email' do
        expect {
          post '/users', params: invalid_params
        }.to_not change(User, :count)
      end
    end
  end
  

  describe "POST /sign_in" do

    context 'Sign In' do
      let(:user) { FactoryBot.create(:user) }
      let(:interest) { FactoryBot.create(:interest) }
      let(:qualification) { FactoryBot.create(:qualification) }
      let(:academics) { FactoryBot.create(:academic, user_id: user.id, interest_id: interest.id, qualification_id: qualification.id) }

      it "Allow to login" do
        p academics.user_id
        post '/users/sign_in', params: {user: {email: user.email, password: user.password }}
        expect(response.status).to eq(200)
      end

      it "With Invalid Email" do
        post '/users/sign_in', params: {user: {email: Faker::Internet.email, password: user.password }}
        expect(response.status).to_not eq(200)
      end
    end
  end
end
