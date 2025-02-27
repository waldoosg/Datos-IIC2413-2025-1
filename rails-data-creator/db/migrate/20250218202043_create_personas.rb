class CreatePersonas < ActiveRecord::Migration[8.0]
  def change
    create_table :personas do |t|
      t.string :nombre
      t.integer :run
      t.integer :dv
      t.string :correo
      t.string :contrasena
      t.string :username
      t.string :telefono_contacto
      t.integer :puntos
      t.string :jornada
      t.string :isapre
      t.string :contrato

      t.timestamps
    end
  end
end
