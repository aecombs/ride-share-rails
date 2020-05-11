class Driver < ApplicationRecord
    has_many :trips

    validates :name, presence: true
    validates :vin, presence: true, length: { is: 17 }, format: { with: /[0-9A-Z]/ }

    def total_earning
        total = 0 
        self.trips.each do |trip|
            total += trip.cost
        end
        num = (total - 1.65) * 0.8
        return num.round(2)
    end

    def average_rating
        total_rating = 0 
        self.trips.each do |trip|
            total_rating += trip.rating
        end
        return total_rating / self.trips.length
    end
end
