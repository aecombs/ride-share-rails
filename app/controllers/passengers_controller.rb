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
    end

    def update
    end

    def destroy
    end
end
