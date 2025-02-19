class Panorama < ApplicationRecord
  has_many :reserva
  has_many :participante
end
