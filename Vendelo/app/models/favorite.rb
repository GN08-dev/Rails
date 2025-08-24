class Favorite < ApplicationRecord
  # validar que no se repita el valor en el mismo usuario
  validates :user, uniqueness: { scope: :product }
  # definimos la relacion con productos y usuarios  y en usuario se define tambien que hay una relacion con favorite
  belongs_to :user
  belongs_to :product
end
