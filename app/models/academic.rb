class Academic < ApplicationRecord
  belongs_to :user
  belongs_to :interest
  belongs_to :qualification
  has_one_attached :cv
  has_one_attached :government_id


  validates :college_name, presence: true
  validates :career_goals, presence: true
  validates :known_languages, presence: true
  validates :currently_working,presence: true
  validates :specialization, presence: true
  validates :total_experience, presence: true
  validates :availability, presence: true
  validates :user_id, presence: true
  validates :interest_id, presence: true
  validates :qualification_id, presence: true
end
