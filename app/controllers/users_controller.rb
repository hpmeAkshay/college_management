class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])    
    render json: {user: ActiveModelSerializers::SerializableResource.new(@user), message: "Events Listed successfully", status: 200}
  end
  

  def update

  end

  def destroy

  end
end
