class CreateReservas < ActiveRecord::Migration[8.0]
  def change
    create_table :reservas do |t|
      t.references :agenda, null: false, foreign_key: { to_table: :agendas }
      t.date :fecha
      t.float :monto
      t.integer :cantidad_personas

      t.timestamps
    end
  end
end
