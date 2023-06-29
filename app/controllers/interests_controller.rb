class InterestsController < ApplicationController
    def create
        @interest = Interest.new(interest_params)
       
        if @interest.save 
          render json: {data: @interest, message: "Interest Created successfully", status: 200}
        else
          render json: @interest.errors.full_messages || "Unable To Create Interest", status: :unprocessable_entity
        end
    end
    
    def index
        @interest = Interest.all      
        render json: {data: @interest, message: "Interest Listed successfully", status: 200}
    end 

    private
    def interest_params
        params.require(:interest).permit(:name)
    end
end