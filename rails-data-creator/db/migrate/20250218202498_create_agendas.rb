class CreateAgendas < ActiveRecord::Migration[8.0]
  def change
    create_table :agendas do |t|
      t.text :etiqueta
      t.references :usuario, null: false, foreign_key: { to_table: :usuarios }

      t.timestamps
    end
  end
end
