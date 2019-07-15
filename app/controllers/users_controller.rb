class UsersController < ApplicationController
  before_action :set_user, only: [:edit,:update]

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to edit_user_path, notice:"変更しました。"
    else 
      redirect_to edit_user_path, alert:"変更に失敗しました。"
    end
  end

  def show
  end

  def new
  end

  def create
  end

  private
  def user_params
    params.require(:user).permit(:nickname,:introduce)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
