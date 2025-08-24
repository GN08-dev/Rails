class User < ApplicationRecord
  has_secure_password # para encriptar la contraseña

  validates :email, presence: true, uniqueness: true,
  format: {
      with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
      message: :invalid
    }

  validates :username, presence: true, uniqueness: true,
  length: { minimum: 3, maximum: 15 },
  format: { with: /\A[a-zA-Z0-9\-]+\z/,
            message: :invalid
    }

  validates :password, length: { minimum: 6 }
  # un usuario puede tener varios productos
  has_many :products, dependent: :destroy # la dependencia es borrar todos sus productos si el usuario es eliminado
  before_save :downcase_attributes
  # relacion con la tabla favorites del modelo
  has_many :favorites,  dependent: :destroy

  private
  def downcase_attributes
    self.username = username.downcase
  end
end
