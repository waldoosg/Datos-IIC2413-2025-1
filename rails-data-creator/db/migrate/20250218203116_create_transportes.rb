class CreateTransportes < ActiveRecord::Migration[8.0]
  def change
    create_table :transportes do |t|
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
      t.string :tipo
      t.text :comodidades, array: true, default: []
      t.string :escalas, array: true, default: []
      t.string :clase
      t.string :paradas, array: true, default: []
      t.references :reservas, foreign_key: true

      t.timestamps
    end
  end
end
