class CakesController < ApplicationController
  def new

  end

  def create
  	@cake = Cake.create(flavor: "chocolate", message: "I made this for you! Hope you like it!", user_id: )
  end

  def destroy
  end

  def give
  end
end
