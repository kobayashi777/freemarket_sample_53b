class UsersController < ApplicationController


  def edit
  @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to "/users/#{@user.id}/edit", notice:"変更しました。"
    else 
      redirect_to "/users/#{@user.id}/edit", alert:"変更に失敗しました。"
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
end
