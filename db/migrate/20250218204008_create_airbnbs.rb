class CreateAirbnbs < ActiveRecord::Migration[8.0]
  def change
    create_table :airbnbs do |t|
      t.string :nombre_anfitrion
      t.string :contacto_anfitrion
      t.text :descripcion
      t.integer :piezas
      t.integer :camas
      t.integer :banos

      t.timestamps
    end
  end
end
