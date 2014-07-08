require 'pry'
class CakesController < ApplicationController
  before_action :signed_in_user
 
  def create
  	@cake = current_user.cakes.build(flavor: "chocolate", 
  		message: "I made this for you! Hope you like it!", 
  		user_id: current_user.id, has_been_given: false, baked_by: current_user.name)
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
    @cake = current_user.cakes.find_by(has_been_given: false)
    if (@cake == nil)
       flash[:been_given] = "You don't have any cakes to give."
       redirect_to "/users/" + current_user.id.to_s
    elsif current_user.cakes.count > 0 
      @cake.update_attributes!(user_id: params[:id], has_been_given: true)
      current_user.update_attribute(:happiness, (current_user.happiness + 1.0))
      User.find(params[:id]).update_attribute(:happiness, (User.find(params[:id]).happiness + 0.5))
      redirect_to "/users/" + params[:id]
    else
      flash[:no_more_cakes] = 'You have no more cakes to give.'
      redirect_to "/users/" + current_user.id.to_s
    end
  end

end
