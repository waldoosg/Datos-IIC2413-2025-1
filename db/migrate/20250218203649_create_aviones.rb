class CreateAviones < ActiveRecord::Migration[8.0]
  def change
    create_table :aviones do |t|
      t.string :escalas, array: true, default: []
      t.string :clase

      t.timestamps
    end
  end
end
