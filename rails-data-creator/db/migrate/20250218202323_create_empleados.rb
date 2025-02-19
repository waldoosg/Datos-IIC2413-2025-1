class CreateEmpleados < ActiveRecord::Migration[8.0]
  def change
    create_table :empleados do |t|
      t.string :jornada
      t.string :isapre
      t.string :contrato

      t.timestamps
    end
  end
end
