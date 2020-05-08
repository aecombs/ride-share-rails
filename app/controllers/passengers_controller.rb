class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all
  end

  def new
      
  end

  def create
  end

  def show
    @passenger = Passenger.find_by(id: params[:id].to_i)
    if @passenger.nil?
      head :not_found
      return
    end
  end

  def edit
    @passenger = Passenger.find_by(id: params[:id].to_i)
    if @passenger.nil?
      head :not_found
      return
    end

  end

  def update
    @passenger = Passenger.find_by(id: params[:id].to_i)
    if @passenger.nil?
      head :not_found
      return
    elsif @passenger.update(passenger_params)
      redirect_to passenger_path(@passenger.id)
      return
    else
      render :edit
      return
    end
  end

  def destroy
  end

  private

  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num)
  end
end
