class Trip < ApplicationRecord
    belongs_to :driver
    belongs_to :passenger

    validates :cost, presence: true, numericality: true

    def self.generate_cost
        return rand(5..299.99).round(2)
    end
end
