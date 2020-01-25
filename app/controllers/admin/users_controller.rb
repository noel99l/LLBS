class Admin::UsersController < AdminController
  def index
  	@users = User.paginate(page: params[:page], per_page: 20)
  end

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
    flash[:success] = "#{user.name}を更新しました！"
  	redirect_to admin_user_path(user)
  end

  private
  def user_params
  	params.require(:user).permit(:name, :email, :introduction, :image)
  end
end
