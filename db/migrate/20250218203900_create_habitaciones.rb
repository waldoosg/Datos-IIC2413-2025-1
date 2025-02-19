class CreateHabitaciones < ActiveRecord::Migration[8.0]
  def change
    create_table :habitaciones do |t|
      t.integer :numero_habitacion
      t.references :hotel, null: false, foreign_key: { to_table: :hospedajes }

      t.timestamps
    end
  end
end
