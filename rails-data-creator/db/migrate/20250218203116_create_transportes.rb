class CreateTransportes < ActiveRecord::Migration[8.0]
  def change
    create_table :transportes do |t|
      t.references :reserva, null: false, foreign_key: { to_table: :reservas }
      t.references :empleado, null: false, foreign_key: { to_table: :personas }
      t.integer :numero_viaje
      t.string :lugar_origen
      t.string :lugar_llegada
      t.integer :capacidad
      t.integer :tiempo_estimado
      t.float :precio_asiento
      t.string :empresa
      t.string :tipo
      t.text :comodidades, array: true, default: []
      t.string :escalas, array: true, default: []
      t.string :clase
      t.string :paradas, array: true, default: []

      t.timestamps
    end
  end
end
