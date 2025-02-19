class CreateUsuarios < ActiveRecord::Migration[8.0]
  def change
    create_table :usuarios do |t|
      t.integer :puntos

      t.timestamps
    end
  end
end
