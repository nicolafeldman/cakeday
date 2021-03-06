require 'pry'
class CakesController < ApplicationController
  before_action :signed_in_user
 
  def create #hash includes key-value pairs of flavors and their images
    flavors = {"chocolate" => "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcSJNaRrW7SntN3pqaYY2pEVSOZQRPZlM9WKpLXLrPWPNZXgdp46", 
      "vanilla" => "http://sweetclipart.com/multisite/sweetclipart/files/imagecache/middle/food_holidays_birthday_cake_2_with_candles_vanilla.png", 
      "strawberry" => "http://www.foodclipart.com/food_clipart_images/strawberry_cake_0071-0905-1905-0551_SMU.jpg", 
      "coffee" => "http://thumbs.gograph.com/gg59190493.jpg", 
      "ice cream" => "http://www.uncleharrysicecream.com/images/clipart-cake-and-ice-cream-lg.jpg", 
      "cheese" => "http://www.musthavemenus.com/imageservice/images/13/m0703212aa/img_large_watermarked.jpg",
      "birthday" => "http://cakepic4u.com/wp-content/uploads/2014/05/birthday-cakes-pictures-clip-art-4.jpg"}
  	this_flavor = flavors.keys.sample
    @cake = current_user.cakes.build(flavor: this_flavor, 
  		message: "", 
  		user_id: current_user.id, 
      has_been_given: false, 
      baked_by: current_user.name, 
      photo: flavors[this_flavor] )
  	  if @cake.save
  	  	flash[:success] = "Your Cake is Baked :)"
		    redirect_to current_user
	  else
	  	render 'static_pages/help'
	  end
  end

  def destroy
  end

  def give
    @cakes = current_user.cakes.where("has_been_given = ?", false)
  end

  def transfercake #essentially, subtract one from giver and add one to receiver
    @cake = current_user.cakes.find(params[:cake_id])
    if (@cake == nil)
       flash[:been_given] = "You don't have any cakes to give."
       redirect_to "/users/" + current_user.id.to_s
    elsif current_user.cakes.count > 0 
      @cake.update_attributes!(user_id: params[:id], has_been_given: true, message: params[:message])
      current_user.update_attribute(:happiness, (current_user.happiness + 1.0)) #happiness is increased when giving cake
      User.find(params[:id]).update_attribute(:happiness, (User.find(params[:id]).happiness + 0.5)) #happiness is increased by smaller margin when receiving cake
      redirect_to "/users/" + params[:id]
    else
      flash[:no_more_cakes] = 'You have no more cakes to give.'
      redirect_to "/users/" + current_user.id.to_s
    end
  end



end
