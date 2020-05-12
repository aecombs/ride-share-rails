require "test_helper"

describe TripsController do
  before do
    @passenger = Passenger.create(name: "Alla Baster", phone_num: "867-5309")
    @driver = Driver.create(name: "Hollie Day", vin: "123ABC456DEF789GH", available: true)
    @trip = Trip.create(date: Date.today, cost: Trip.generate_cost, passenger_id: @passenger.id, driver_id: @driver.id)
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

  describe "create" do
    it "will create a new trip without taking parameters" do
      expect{
        post passenger_trips_path(@passenger.id), params: nil
      }.must_change "Trip.count", 1

      new_trip = Trip.find_by(id: @passenger.trips.last.id)

      expect(new_trip.driver.available).must_equal false

      must_respond_with :redirect
      must_redirect_to passenger_path(@passenger.id)
    end
  end

  describe "edit" do
    it "can render edit view for a valid trip" do
      get edit_trip_path(@trip.id)
      must_respond_with :success
    end

    it "will return not_found for invalid trip" do
      get edit_trip_path(-5)
      must_respond_with :not_found
    end
  end

  describe "update" do
    it "will update a valid trip" do
      trip_params = {
        trip: {
          cost: 22,
          date: Date.today,
          rating: 5
        }
      }

      expect{
        patch trip_path(@trip.id), params: trip_params
      }.must_differ "Trip.count", 0

      expect(@passenger.trips.last.cost).must_equal trip_params[:trip][:cost]
      expect(@passenger.trips.last.date).must_equal trip_params[:trip][:date]
      expect(@passenger.trips.last.rating).must_equal trip_params[:trip][:rating]
    end

    it "will return not_found for invalid trip id" do
      patch trip_path(-5)
      must_respond_with :not_found
    end
  end

  describe "destroy" do
    it "can remove a trip" do
      new_trip = Trip.create(date: Date.today, cost: Trip.generate_cost, passenger_id: @passenger.id, driver_id: @driver.id)

      expect{
        delete trip_path(new_trip.id)
      }.must_differ "Trip.count", -1
      must_redirect_to trips_path
    end

    it "will return not_found if given invalid trip id" do
      delete trip_path(-5)
      must_respond_with :not_found
    end
  end
end
