class Trip < ApplicationRecord
    belongs_to :driver
    belongs_to :passenger

    #TODO: validate :cost, :date
end
