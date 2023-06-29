class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :full_phone_number, :email, :gender, :role, :date_of_birth, :country, :city, :state, :address
  has_one :academic
  
end
