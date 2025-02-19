class CreatePanoramas < ActiveRecord::Migration[8.0]
  def change
    create_table :panoramas do |t|
      t.references :reserva, null: false, foreign_key: { to_table: :reservas }
      t.string :empresa
      t.string :nombre_panorama
      t.text :descripcion
      t.string :ubicacion
      t.integer :duracion
      t.float :precio_persona
      t.integer :capacidad
      t.text :restricciones, array: true, default: []

      t.timestamps
    end
  end
end
