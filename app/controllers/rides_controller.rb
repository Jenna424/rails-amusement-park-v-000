class RidesController < ApplicationController

  def new
    @ride = Ride.create(user_id: params[:user_id], attraction_id: params[:attraction_id])

    @message = @ride.take_ride

    redirect_to user_path(@ride.user, message: @message)
  end

end
# When form is submitted by clicking "Go on this ride" button on attraction show page,
# form data is submitted via a POST request to "/rides/new", mapped to rides#new
# params has top-level "user_id" and "attraction_id" keys
