class CreatePanoramas < ActiveRecord::Migration[8.0]
  def change
    create_table :panoramas do |t|
      t.string :empresa
      t.string :nombre_panorama
      t.text :descripcion
      t.string :ubicacion
      t.integer :duracion
      t.float :precio_persona
      t.integer :capacidad
      t.text :restricciones, array: true, default: []
      t.date :fecha_panorama
      t.references :reservas, foreign_key: true

      t.timestamps
    end
  end
end
