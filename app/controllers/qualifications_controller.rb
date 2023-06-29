class QualificationsController < ApplicationController
  def create
      @qualification = Qualification.new(qualification_params)
     
      if @qualification.save 
        render json: {data: @qualification, message: "Qualification Created successfully", status: 200}
      else
        render json: @qualification.errors.full_messages || "Unable To Create Qualification", status: :unprocessable_entity
      end
  end 

  def index
    @qualification = Qualification.all      
    render json: {data: @qualification, message: "Qualification Listed successfully", status: 200}
end 

  private
  def qualification_params
      params.require(:qualifications).permit(:name)
  end
end
