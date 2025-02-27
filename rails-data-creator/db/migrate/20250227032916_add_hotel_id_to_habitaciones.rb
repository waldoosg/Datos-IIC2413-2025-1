class AddHotelIdToHabitaciones < ActiveRecord::Migration[8.0]
  def change
    add_reference :habitaciones, :hotel, null: false, foreign_key: { to_table: :hoteles }
  end
end
