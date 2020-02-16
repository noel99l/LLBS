class UsersController < ApplicationController
  before_action :baria_user, only: [:edit, :update]
      #url直接防止 メソッドを自己定義してbefore_actionで発動。
    def baria_user
      unless User.find(params[:id]).id == current_user.id
        redirect_to root_path
      end
    end

  def twitter_new
  end

  def twitter_update
    user = User.find(params[:id])
    user.update(user_params)
    flash[:success] = "#{user.name}さん LLBSへの登録ありがとうございます！"
    redirect_to user_path(user.id)
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
    flash[:success] = "#{user.name}さんのプロフィールを更新しました！"
  	redirect_to user_path(user.id)
  end

  private
  def user_params
  	params.require(:user).permit(:name, :email, :introduction, :image)
  end
end