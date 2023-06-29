class Qualification < ApplicationRecord
    has_one :academic
    validates :name, presence: { message: "can't be blank" }
end
