class CreateBuses < ActiveRecord::Migration[8.0]
  def change
    create_table :buses do |t|
      t.string :tipo
      t.text :comodidades, array: true, default: []

      t.timestamps
    end
  end
end
