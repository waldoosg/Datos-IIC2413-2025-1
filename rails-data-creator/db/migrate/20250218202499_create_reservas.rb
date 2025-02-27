class CreateReservas < ActiveRecord::Migration[8.0]
  def change
    create_table :reservas do |t|
      t.references :agenda, foreign_key: { to_table: :agendas }
      t.date :fecha
      t.float :monto
      t.integer :cantidad_personas
      t.string :estado_disponibilidad, default: 'Disponible'
      t.references :empleado, foreign_key: { to_table: :empleados }
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
      t.string :nombre_hospedaje
      t.string :ubicacion
      t.float :precio_noche
      t.float :estrellas
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
      t.string :nombre_panorama
      t.integer :duracion
      t.float :precio_persona
      t.text :restricciones, array: true, default: []
      t.date :fecha_panorama

      t.timestamps
    end
  end
end
