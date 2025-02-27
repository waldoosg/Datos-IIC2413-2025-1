class CreateEmpleados < ActiveRecord::Migration[8.0]
  def change
    create_table :empleados do |t|
      t.string :nombre
      t.integer :run
      t.integer :dv
      t.string :correo
      t.string :contrasena
      t.string :username
      t.string :telefono_contacto
      t.string :jornada
      t.string :isapre
      t.string :contrato
      t.references :personas, foreign_key: true

      t.timestamps
    end
  end
end
