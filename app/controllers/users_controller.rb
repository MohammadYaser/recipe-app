class UsersController < ApplicationController
  # Action to display a list of all users
  def index
    @users = User.all
  end

  # Action to show details of a specific user
  def show
    @user = User.find_by_id(params[:id])

    # Redirect to the users index if the user is not found
    return unless @user.nil?

    redirect_to users_path
  end
end
