class TripsController < ApplicationController
  def index
    if params[:passenger_id]
      passenger = Passenger.find_by(id: params[:passenger_id])
      @trips = passenger.trips
    elsif params[:driver_id]
      driver = Driver.find_by(id: params[:driver_id])
      @trips = driver.trips
    else
      @trips = Trip.order("id ASC").all
    end
  end

  def show
    @trip = Trip.find_by(id: params[:id])
    
    if @trip.nil?
      redirect_to trips_path
      return
    end
  end


  def create
    @passenger = Passenger.find_by(id: params[:passenger_id])

    @trip = Trip.new(date: Date.today, cost: Trip.generate_cost, passenger_id: @passenger.id, driver_id: Driver.select_driver)

    if @trip.save
      @trip.driver.update(available: false)
      redirect_to passenger_path(@passenger.id)
      return
    else
      render :bad_request
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
    @trip = Trip.find_by(id: params[:id].to_i)

    if @trip.nil?
        head :not_found
        return
    elsif @trip.update(trip_params)
        redirect_to trip_path(@trip.id)
        return
    else
        render :edit
        return 
    end
  end

  def destroy
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      head :not_found
      return
    end

    @trip.destroy
    redirect_to trips_path
    return
  end

  private

  def trip_params
    return params.require(:trip).permit(:cost, :rating, :date)
  end
end
