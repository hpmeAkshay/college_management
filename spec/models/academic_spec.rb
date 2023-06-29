require 'rails_helper'

RSpec.describe Academic, type: :model do
  describe 'validations' do
    it 'validates presence of college_name' do
      academic = Academic.new(college_name: '')
      expect(academic).to_not be_valid
      expect(academic.errors[:college_name]).to include("can't be blank")
    end

    it 'validates presence of career_goals' do
      academic = Academic.new(career_goals: '')
      expect(academic).to_not be_valid
      expect(academic.errors[:career_goals]).to include("can't be blank")
    end

    it 'validates presence of known_languages' do
      academic = Academic.new(known_languages: '')
      expect(academic).to_not be_valid
      expect(academic.errors[:known_languages]).to include("can't be blank")
    end

    it 'validates presence of currently_working' do
      academic = Academic.new(currently_working: '')
      expect(academic).to_not be_valid
      expect(academic.errors[:currently_working]).to include("can't be blank")
    end

    it 'validates presence of specialization' do
      academic = Academic.new(specialization: '')
      expect(academic).to_not be_valid
      expect(academic.errors[:specialization]).to include("can't be blank")
    end

    it 'validates presence of total_experience' do
      academic = Academic.new(total_experience: '')
      expect(academic).to_not be_valid
      expect(academic.errors[:total_experience]).to include("can't be blank")
    end

    it 'validates presence of availability' do
      academic = Academic.new(availability: '')
      expect(academic).to_not be_valid
      expect(academic.errors[:availability]).to include("can't be blank")
    end

    it 'validates presence of user_id' do
      academic = Academic.new(user_id: nil)
      expect(academic).to_not be_valid
      expect(academic.errors[:user_id]).to include("can't be blank")
    end

    it 'validates presence of interest_id' do
      academic = Academic.new(interest_id: nil)
      expect(academic).to_not be_valid
      expect(academic.errors[:interest_id]).to include("can't be blank")
    end

    it 'validates presence of qualification_id' do
      academic = Academic.new(qualification_id: nil)
      expect(academic).to_not be_valid
      expect(academic.errors[:qualification_id]).to include("can't be blank")
    end
  end
end
