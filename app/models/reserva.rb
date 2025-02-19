class Reserva < ApplicationRecord
  has_many :seguros
  has_many :reviews
  belongs_to :agenda
end
