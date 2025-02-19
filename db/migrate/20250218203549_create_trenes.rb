class CreateTrenes < ActiveRecord::Migration[8.0]
  def change
    create_table :trenes do |t|
      t.string :paradas, array: true, default: []
      t.text :comodidades, array: true, default: []

      t.timestamps
    end
  end
end
