class TripsController < ApplicationController
  def index
    if params[:passenger_id]
      passenger = Passenger.find_by(id: params[:passenger_id])
      @trips = passenger.trips
    elsif params[:driver_id]
      driver = Driver.find_by(id: params[:driver_id])
      @trips = driver.trips
    else
      @trips = Trip.all
    end
  end

  def show
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      head :not_found
      return
    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
      return
    end
  end

  def update
    @trip = Trips.find_by(id: params[:id].to_i)

    if @trip.nil?
        head :not_found
        return
    elsif
        @trip.update(trip_params)
        redirect_to trip_path(@trip.id)
        return
    else
        render :edit
        return 
    end
  end

  def destroy
  end
  private

  def trip_params
    return params.require(:trip).permit(:cost, :rating, :date)
  end
end
