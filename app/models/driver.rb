class Driver < ApplicationRecord
    has_many :trips

    def total_earning
        total = 0 
        self.trips.each do |trip|
            total += trip.cost
        end
        return total
    end

    def average_rating
        total_rating = 0 
        self.trips.each do |trip|
            total_rating += trip.rating
        end
        return total_rating / self.trips.length
    end
end
