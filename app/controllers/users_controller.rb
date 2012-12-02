class UsersController < ActionController::Base
  def show
    @user = User.find(params[:id])
  end

  def destroy
    
  end

end
