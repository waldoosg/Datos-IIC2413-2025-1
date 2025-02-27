class CreateAirbnbs < ActiveRecord::Migration[8.0]
  def change
    create_table :airbnbs do |t|
      t.string :nombre_hospedaje
      t.string :ubicacion
      t.float :precio_noche
      t.float :estrellas
      t.text :comodidades, array: true, default: []
      t.boolean :disponibilidad
      t.string :nombre_anfitrion
      t.string :contacto_anfitrion
      t.text :descripcion
      t.date :fecha_checkin
      t.date :fecha_checkout
      t.integer :piezas
      t.integer :camas
      t.integer :banos
      t.references :hospedajes, foreign_key: true
      t.references :reservas, foreign_key: true

      t.timestamps
    end
  end
end
