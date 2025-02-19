class Empleado < Persona
  has_many :trasnporte, foreign_key: :id_empleado
end
