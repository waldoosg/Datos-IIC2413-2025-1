class CreateHospedajes < ActiveRecord::Migration[8.0]
  def change
    create_table :hospedajes do |t|
      t.string :nombre_hospedaje
      t.string :ubicacion
      t.float :precio_noche
      t.float :estrellas
      t.text :comodidades
      t.boolean :disponibilidad
      t.date :fecha_checkin
      t.date :fecha_checkout
      t.string :politicas, array: true, default: []
      t.string :nombre_anfitrion
      t.string :contacto_anfitrion
      t.text :descripcion
      t.integer :piezas
      t.integer :camas
      t.integer :banos
      t.references :reservas, foreign_key: true

      t.timestamps
    end
  end
end
