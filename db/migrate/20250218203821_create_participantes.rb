class CreateParticipantes < ActiveRecord::Migration[8.0]
  def change
    create_table :participantes do |t|
      t.references :panorama, null: false, foreign_key: { to_table: :panoramas }
      t.string :nombre_participante

      t.timestamps
    end
  end
end
