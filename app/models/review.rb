class Review < ApplicationRecord
  belongs_to :usuario, foreign_key: :id_usuario
  belongs_to :reserva, foreign_key: :id_reserva
end
