class Seguro < ApplicationRecord
  belongs_to :usuario
  belongs_to :reserva
end
