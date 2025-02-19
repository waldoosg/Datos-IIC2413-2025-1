class Usuario < Persona
  has_many :agenda, foreign_key: :id_usuario
  has_many :review, foreign_key: :id_usuario
  has_many :seguro, foreign_key: :id_usuario
end
