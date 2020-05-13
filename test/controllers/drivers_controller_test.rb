require "test_helper"

describe DriversController do
  describe "index" do
    it "responds with success when there are many drivers saved" do
      # Arrange
      Driver.create(name: "Mair Bear", vin: "123ABC456EFG789HI", available: true)

      # Act
      get drivers_path

      # Assert
      must_respond_with :success
    end

    it "responds with success when there are no drivers saved" do
      # Arrange
      # Ensure that there are zero drivers saved

      # Act
      get drivers_path

      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success when showing an existing valid driver" do
      # Arrange
      # Ensure that there is a driver saved
      driver = Driver.create(name: "Mair Bear", vin: "123ABC456EFG789HI", available: true)
      puts "drivers save"

      # Act
      get driver_path(driver.id)

      # Assert
      must_respond_with :success
    end

    it "responds with 404 with an invalid driver id" do
      # Arrange
      # Ensure that there is an id that points to no driver

      # Act
      get driver_path(-1)

      # Assert
      must_respond_with :not_found
    end
  end

  describe "new" do
    it "responds with success" do
      get new_driver_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new driver with valid information accurately, and redirect" do
      # Arrange
      # Set up the form data
      driver_hash = {
        driver: {
          name: "Mair Bear",
          vin: "123ABC456EFG789HI",
          available: true,
        },
      }

      # Act-Assert
      # Ensure that there is a change of 1 in Driver.count
      expect {
        post drivers_path, params: driver_hash
      }.must_change "Driver.count", 1

      # Assert
      # Find the newly created Driver, and check that all its attributes match what was given in the form data
      # Check that the controller redirected the user
      added_driver = Driver.find_by(name: driver_hash[:driver][:name])
      expect(added_driver.vin).must_equal driver_hash[:driver][:vin]
      expect(added_driver.available).must_equal driver_hash[:driver][:available]

      must_respond_with :redirect
      must_redirect_to drivers_path
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates Driver validations
      driver_hash = {
        driver: {
          name: "Mair Bear",
          vin: "123ABC456EFG789HIJKLMNOPQRSTWHAT!",
          available: true,
        },
      }

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        post drivers_path, params: driver_hash
      }.wont_change "Driver.count"

      # Assert
      # Check that the controller redirects
      # must_respond_with :redirect
      # must_redirect_to new_driver_path
      # assert_template :new
    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      # Arrange
      # Ensure there is an existing driver saved
      driver = Driver.create(name: "Mair Bear", vin: "123ABC456EFG789HI", available: true)

      # Act
      get edit_driver_path(driver.id)

      # Assert
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing driver" do
      # Arrange
      # Ensure there is an invalid id that points to no driver

      # Act
      get edit_driver_path(-1)

      # Assert
      must_respond_with :not_found
    end
  end

  describe "update" do
    it "can update an existing driver with valid information accurately, and redirect" do
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data
      driver = Driver.create(name: "Mair Bear", vin: "123ABC456EFG789HI", available: true)
      driver_hash = {
        driver: {
          name: "changed driver:(",
          vin: "12345678910ABCDEF",
          available: true,
        },
      }

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path(driver.id), params: driver_hash
      }.wont_change "Driver.count"

      # Assert
      # Use the local variable of an existing driver's id to find the driver again, and check that its attributes are updated
      # Check that the controller redirected the user
      expect(Driver.last.name).must_equal driver_hash[:driver][:name]
      expect(Driver.last.vin).must_equal driver_hash[:driver][:vin]
      expect(Driver.last.available).must_equal driver_hash[:driver][:available]

      must_respond_with :redirect
      must_redirect_to driver_path(Driver.last.id)
    end

    it "does not update any driver if given an invalid id, and responds with a 404" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      # Set up the form data

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path(-1)
      }.wont_change "Driver.count"

      # Assert
      # Check that the controller gave back a 404
      must_respond_with :not_found
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data so that it violates Driver validations
      driver = Driver.create(name: "Mair Bear", vin: "123ABC456EFG789HI", available: true)
      driver_hash = {
        driver: {
          name: "changed driver!",
          vin: "12345678910ABCDEFWHATTTTT!!!!",
          available: true,
        },
      }

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path(driver.id), params: driver_hash
      }.wont_change "Driver.count"

      # Assert
      # Check that the controller redirects
      expect(Driver.last.name).must_equal driver[:name]
      expect(Driver.last.vin).must_equal driver[:vin]
      expect(Driver.last.available).must_equal driver[:available]

      # assert_template :edit
    end
  end

  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do
      # Arrange
      # Ensure there is an existing driver saved
      driver = Driver.create(name: "Mair Bear", vin: "123ABC456EFG789HI", available: true)

      # Act-Assert
      # Ensure that there is a change of -1 in Driver.count
      expect {
        delete driver_path(driver.id)
      }.must_differ "Driver.count", -1

      # Assert
      # Check that the controller redirects
      must_respond_with :redirect
      must_redirect_to drivers_path
    end

    it "does not change the db when the driver does not exist, then responds with " do
      # Arrange
      # Ensure there is an invalid id that points to no driver

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        delete driver_path(-1)
      }.wont_change "Driver.count"

      # Assert
      # Check that the controller responds or redirects with whatever your group decides
      must_respond_with :not_found
    end
  end

  describe "change_availability" do
    it "will change a a valid driver's availabity" do
      #Arrange
      driver = Driver.create(name: "Mair Bear", vin: "123ABC456EFG789HI", available: true)

      #Act
      expect {
        patch change_availability_path(driver.id)
      }.wont_change "Driver.count"

      #Assert
      expect(Driver.last.available).must_equal false
      must_respond_with :redirect
      must_redirect_to driver_path(driver.id)
    end

    it "does not change a driver's availabilty when given an invalid driver's id" do
      #Arrange

      #Act
      expect {
        patch change_availability_path(-1)
      }.wont_change "Driver.count"

      #Assert
      must_respond_with :not_found
    end
  end
end
