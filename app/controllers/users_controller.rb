class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
    @event_users = EventUser.where(user_id: @user.id)
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	user = User.find(params[:id])
  	user.update(user_params)
  	redirect_to user_path(user.id)
  end

  private
  def user_params
  	params.require(:user).permit(:name, :email, :introduction, :image)
  end
end