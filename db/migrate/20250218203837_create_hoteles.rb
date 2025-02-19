class CreateHoteles < ActiveRecord::Migration[8.0]
  def change
    create_table :hoteles do |t|
      t.string :politicas, array: true, default: []

      t.timestamps
    end
  end
end
