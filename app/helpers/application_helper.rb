module ApplicationHelper
  def check_user(user_id)
    #logged in user is same as user_id
    @current_user && user_id && @current_user.id == user_id
  end
end
