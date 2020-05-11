class Passenger < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  #Regex taken from https://stackoverflow.com/questions/16699007/regular-expression-to-match-standard-10-digit-phone-number#16699507
  #regex to validate phone_num format: { with: /[^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$]/ }
  validates :phone_num, presence: true

  def total_charged
    total = 0
    self.trips.each do |trip|
      total += trip.cost
    end
    return total
  end
end
