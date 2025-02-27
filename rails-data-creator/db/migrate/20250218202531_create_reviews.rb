class CreateReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :reviews do |t|
      t.float :estrellas
      t.text :descripcion
      t.references :usuario, null: false, foreign_key: { to_table: :usuarios }
      t.references :reserva, null: false, foreign_key: { to_table: :reservas }

      t.timestamps
    end
  end
end
