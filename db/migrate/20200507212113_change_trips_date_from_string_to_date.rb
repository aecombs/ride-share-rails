class ChangeTripsDateFromStringToDate < ActiveRecord::Migration[6.0]
  def change
    change_column :trips, :date, 'date USING "date"::date'
  end
end
