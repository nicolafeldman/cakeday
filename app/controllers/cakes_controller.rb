class CakesController < ApplicationController
  before_action :signed_in_user
 
  def create
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

  def destroy
  end

  def transfercake
    if current_user.cakes.count > 0
      @cake = current_user.cakes.first
      @cake.update_attributes(user_id: params[:id])
      redirect_to "/users/" + params[:id]
    else
      flash[:no_more_cakes] = 'You have no more cakes to give.'
      redirect_to "/users/" + current_user.id.to_s
    end
  end

end
