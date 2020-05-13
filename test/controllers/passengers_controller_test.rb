require "test_helper"

describe PassengersController do
  before do
    @passenger = Passenger.create(name: "Telli Tubbies", phone_num: "555-123-4567")
  end
  describe "index" do
    it "can get the index path" do
      get passengers_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "can show a valid passenger" do
      get passenger_path(@passenger.id)
      must_respond_with :success
    end

    it "will redirect for an invalid passenger" do
      get passenger_path(-5)
      must_respond_with :redirect  
    end
  end

  describe "new" do
    # Your tests go here
    it "can get the new passenger view" do
      get new_passenger_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new passenger" do
      passenger_params = {
        passenger: {
          name: "Anna Banana",
          phone_num: "123-456-7890"
        },
      }
      
      expect{
        post passengers_path, params: passenger_params
      }.must_change "Passenger.count", 1
      
      new_passenger = Passenger.find_by(name: passenger_params[:passenger][:name])
      expect(new_passenger.phone_num).must_equal passenger_params[:passenger][:phone_num]
      
      must_respond_with :redirect
      must_redirect_to passenger_path(new_passenger.id)
    end

    it "will redirect when invalid params are given" do
      passenger_params = {
        passenger: {
          name: "Anna Banana"
        },
      }

      expect {
        post passengers_path, params: passenger_params
      }.must_differ "Passenger.count", 0
    end
  end

  describe "update" do
    it "can update an existing passenger" do
      name = @passenger.name
      passenger_params = {
        passenger: {
          name: "Hermione Granger",
          phone_num: @passenger.phone_num
        }
      }

      expect{
        patch passenger_path(@passenger.id), params: passenger_params
      }.must_differ "Passenger.count", 0

      must_redirect_to passenger_path(@passenger.id)
 
      expect(Passenger.last.name).wont_equal name
    end

    it "won't update an existing passenger if it doesn't pass validations" do
      name = @passenger.name
      passenger_params = {
        passenger: {
          name: "Hermione Granger",
          phone_num: @passenger.phone_num
        }
      }
    end
  end

  describe "edit" do
    it "will show to edit view" do
      get edit_passenger_path(@passenger.id)
      must_respond_with :success
    end

    it "will respond with not_found if invalid id is given" do
      get edit_passenger_path(-5)
      must_respond_with :not_found
    end
  end

  describe "destroy" do
    it "will remove a passenger and its trips" do
      new_passenger = Passenger.create(name: "Sally BoBally", phone_num: "867-5309")
      new_driver = Driver.create(name: "Hollie Day", vin: "123ABC456DEF789GH", available: true)
      new_trip = Trip.create(date: Date.today, cost: Trip.generate_cost, passenger_id: new_passenger.id, driver_id: new_driver.id)

      expect{
        delete passenger_path(new_passenger.id)
      }.must_differ "Passenger.count", -1
      expect(Trip.find_by(id: new_trip.id)).must_be_nil
      expect(Passenger.find_by(id: new_passenger.id)).must_be_nil
      expect(Driver.find_by(id: new_driver.id)).wont_be_nil
    end

    it "will respond with not_found if invalid id is given" do
      delete passenger_path(-5)
      must_respond_with :not_found
    end
  end
end
