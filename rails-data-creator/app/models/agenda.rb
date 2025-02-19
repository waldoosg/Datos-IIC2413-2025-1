class Agenda < ApplicationRecord
  has_many :reserva, foreign_key: :id_agenda
  belongs_to :usuario
end
