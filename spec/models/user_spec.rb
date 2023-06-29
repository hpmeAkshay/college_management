require 'rails_helper'


  RSpec.describe User, type: :model do
    subject(:user) { FactoryBot.build(:user) }

    describe 'generate_jwt' do
      it 'generates the valid jwt token' do
        jwt_token=user.generate_jwt
        expect(jwt_token).to be_a(String)
      end
    end

    describe 'jwt_payload' do
      it 'returns the jwt payload' do
        payload=user.jwt_payload
        expect(payload).to be_a(Hash)
      end
    end

    describe 'validations' do
      it 'validates presence of first_name' do
        user = User.new(first_name: '')
        expect(user).to_not be_valid
        expect(user.errors[:first_name]).to include("can't be blank")
      end

      it 'validates presence of last_name' do
        user = User.new(last_name: '')
        expect(user).to_not be_valid
        expect(user.errors[:last_name]).to include("can't be blank")
      end

      context 'phone number' do
        it 'validates presence of full_phone_number' do
          user = User.new(full_phone_number: '')
          expect(user).to_not be_valid
          expect(user.errors[:full_phone_number]).to include("can't be blank")
        end

        it 'is valid with a 10-digit number and country code' do
          user.full_phone_number = '+919384512713'
          expect(user).to be_valid
        end
  
      it 'is invalid without a country code' do
          user.full_phone_number = '9384512713'
          expect(user).to be_invalid
          expect(user.errors[:full_phone_number]).to include('should be a 10-digit number with country code')
        end
  
        it 'is invalid with a non-numeric value' do
          user.full_phone_number = '+91938abc2713'
          expect(user).to be_invalid
          expect(user.errors[:full_phone_number]).to include('should be a 10-digit number with country code')
        end
      end

      

    end
  end
  
