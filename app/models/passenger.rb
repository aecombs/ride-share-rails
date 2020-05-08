class Passenger < ApplicationRecord
  has_many :trips

  def total_charged
    total = 0
    self.trips.each do |trip|
      total += trip.cost
    end
    return total
  end
end
