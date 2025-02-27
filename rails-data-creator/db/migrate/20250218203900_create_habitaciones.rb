class CreateHabitaciones < ActiveRecord::Migration[8.0]
  def change
    create_table :habitaciones do |t|
      t.integer :numero_habitacion
      t.string :tipo, null: false, default: 'Sencilla'

      t.timestamps
    end
  end
end
