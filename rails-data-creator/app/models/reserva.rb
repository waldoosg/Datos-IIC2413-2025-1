class Reserva < ApplicationRecord
  has_many :seguros
  has_many :reviews
end
