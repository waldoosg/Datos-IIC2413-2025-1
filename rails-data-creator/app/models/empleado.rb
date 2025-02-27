class Empleado < ApplicationRecord
  has_many :transporte, foreign_key: :empleado_id
end
