class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_one :academic, dependent: :destroy
  
  validates :first_name, presence: { message: "can't be blank" }
  validates :last_name, presence: { message: "can't be blank" }
  validates :role, presence: { message: "can't be blank" }
  validates :full_phone_number, presence: { message: "can't be blank" }
  validate :valid_phone_number

  def valid_phone_number
    if full_phone_number.present? && !full_phone_number.match?(/\A\+\d{1,3}\d{10}\z/)
      errors.add(:full_phone_number, "should be a 10-digit number with country code")
    end
  end

  def jwt_payload
    super
  end

  def generate_jwt
    JWT.encode(jwt_payload, Rails.application.credentials.fetch(:secret_key_base))
  end
end
