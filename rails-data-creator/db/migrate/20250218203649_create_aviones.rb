class CreateAviones < ActiveRecord::Migration[8.0]
  def change
    create_table :aviones do |t|
      t.references :empleado, null: false, foreign_key: { to_table: :empleados }
      t.integer :numero_viaje
      t.string :lugar_origen
      t.string :lugar_llegada
      t.integer :capacidad
      t.integer :tiempo_estimado
      t.float :precio_asiento
      t.string :empresa
      t.date :fecha_salida
      t.date :fecha_llegada
      t.string :clase
      t.string :escalas, array: true, default: []
      t.references :transportes, foreign_key: true
      t.references :reservas, foreign_key: true

      t.timestamps
    end
  end
end
