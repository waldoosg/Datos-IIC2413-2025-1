class CreateHoteles < ActiveRecord::Migration[8.0]
  def change
    create_table :hoteles do |t|
      t.string :nombre_hospedaje
      t.string :ubicacion
      t.float :precio_noche
      t.float :estrellas
      t.text :comodidades, array: true, default: []
      t.boolean :disponibilidad
      t.date :fecha_checkin
      t.date :fecha_checkout
      t.string :politicas, array: true, default: []
      t.references :hospedajes, foreign_key: true
      t.references :reservas, foreign_key: true

      t.timestamps
    end
  end
end
