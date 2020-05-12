require "test_helper"

describe TripsController do
  before do
    @passenger = Passenger.create(name: "Alla Baster", phone_num: "867-5309")
    @driver = Driver.create(name: "Hollie Day", vin: "123ABC456DEF789GH", available: true)
    @trip = Trip.create(date: Date.today.to_s, cost: Trip.generate_cost, passenger_id: @passenger.id, driver_id: @driver.id)
  end

  describe "index" do
    it "can get the index path" do
      get trips_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "can show a valid trip" do
      get trip_path(@trip.id)
      must_respond_with :success
    end

    it "will redirect to index if invalid id is given" do
      get trip_path(-5)

      must_redirect_to trips_path
    end
  end

  describe "nested create" do
    it "will create a new trip without taking parameters" do
      expect{
        post passenger_trips_path(@passenger.id), params: nil
      }.must_change "Trip.count", 1

      new_trip = Trip.find_by(id: @passenger.trips.last.id)

      must_respond_with :redirect
      must_redirect_to passenger_path(@passenger.id)
    end
  end

  describe "edit" do

  end

  describe "update" do

  end

  describe "destroy" do

  end
end
