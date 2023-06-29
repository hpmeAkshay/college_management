class AcademicsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      @academic = Academic.new(academic_params)
      if @academic.save
        render json: @academic, status: :created
      else
        render json: { errors: @academic.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def academic_params
      params.permit(:college_name, :career_goals, :known_languages, :other_languages, :currently_working, :specialization, :total_experience, :availability, :user_id, :interest_id, :qualification_id, :cv, :government_id)
    end
end
  
  