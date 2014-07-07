class CakesController < ApplicationController
  before_action :signed_in_user
 
  def create
    if params[:id] != current_user
      redirect_to update #???????
    else
  	@cake = current_user.cakes.build(flavor: "chocolate", 
  		message: "I made this for you! Hope you like it!", 
  		user_id: current_user.id, has_been_given: false)
  	  if @cake.save
  	  	flash[:success] = "Your Cake is Baked :)"
		redirect_to current_user
	  else
	  	render 'static_pages/help'
	  end
  end

  end

  def destroy
  end

  def update
    @cake = current_user.cakes.first
    @cake.update_attribute(user_id: params[:id])
    redirect_to @user
  end

  # def give
  # 	render 'users/show'
  # end
end
