class Agenda < ApplicationRecord
  has_many :reserva, foreign_key: :id_agenda
  has_one :usuario
end
