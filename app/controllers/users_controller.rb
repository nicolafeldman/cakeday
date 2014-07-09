require 'pry'
class UsersController < ApplicationController
  

  def index
    @users = User.all
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      sign_in @user
      flash[:success] = "Welcome to CakeDay!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
  	@user = User.find(params[:id])
  	@cake = current_user.cakes.build if signed_in?
  end

  def map
    @zoom = (21 - ((current_user.happiness.to_i)*0.1).to_i).to_s
    if @zoom.to_i < 0
      @zoom = 0.to_s
    end
  end

private 

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

end
