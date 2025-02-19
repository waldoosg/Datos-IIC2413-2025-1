class CreateSeguros < ActiveRecord::Migration[8.0]
  def change
    create_table :seguros do |t|
      t.string :tipo
      t.float :valor
      t.text :clausula
      t.string :empresa
      t.references :usuario, null: false, foreign_key: { to_table: :personas }
      t.references :reserva, null: false, foreign_key: { to_table: :reservas }

      t.timestamps
    end
  end
end
