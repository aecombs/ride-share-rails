class Driver < ApplicationRecord
    has_many :trips

    validates :name, presence: true
    validates :vin, presence: true, length: { is: 17 }, format: { with: /[0-9A-Z]/ }

    def total_earning
        return 0 if self.trips.length <= 0 
        total = 0 
        self.trips.each do |trip|
            total += trip.cost
        end
        num = (total - 1.65) * 0.8
        return num.round(2)
    end

    def average_rating
        return "No trips" if self.trips.length <= 0 
        total_rating = 0 
        count = 0 
        self.trips.each do |trip|
            if trip.rating
                total_rating += trip.rating
                count += 1
            end
        end
        return total_rating / count
    end
    
    def self.select_driver
        driver = self.all.find {|driver| driver[:available]}
        # driver[:available] = false
        return driver.id
    end
end
