class Hoteles < Hospedaje
  has_many :habitaciones, foreign_key: 'id_hotel'
end
