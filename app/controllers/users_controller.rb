class UsersController < ApplicationController


  def edit
  @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.nickname = "#{user_params[:nickname]}"
    @user.introduce = "#{user_params[:introduce]}"
    if @user.save
    # @user.update(nickname:user_params[:nickname],introduce:user_params[:introduce])
      flash[:notice] = "変更しました。"
      redirect_to "/users/#{@user.id}/edit"
    else 
      # binding.pry
      flash[:alert] = "失敗しました"
      redirect_to "/users/#{@user.id}/edit"
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
