class Hospedaje < ApplicationRecord
  has_many :hoteles
  has_many :airbnbs
  has_many :reserva
end
