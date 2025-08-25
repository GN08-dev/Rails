class Product < ApplicationRecord
  # se agrego pg_search para que funcione en la busqeuda siempre se coloca en el modelo
  include PgSearch::Model
  include Favoritable
  pg_search_scope :search_full_text, against: {
    title: "A",
    descripcion: "B"
    # price: 'C'
  }
  # declaracion de constante
  ORDER_BY = {
      newest: "created_at DESC",
      expensive: "price DESC",
      cheaper: "price asc"
    }
  # las prioridades son de a b c
  # archivos adjuntos para el guardado de imagenes
  # se le coloca que es una foto por convencion si es para un usuario podria ser con un nombre definido de avatar
  has_one_attached  :photo

  # modelo para visualizar los datos
  # validacion de datos
  validates :title, presence: true
  validates :descripcion, presence: true
  validates :price, presence: true

  belongs_to :category


  # asignacion de productos de pertenencias
  # belongs_to :user # lo que decimos es que un producto pertenece a un usuario

  # lectura desde el modelo que por default al usuario se le asignara cuando se crea un nuevo producto
  belongs_to :user, default: -> { Current.user } # le pasamos el usuario que esta logeado

  # metodo owner? para validacion del usuario
  def owner?
    user_id == Current.user&.id
  end
  ################################################################################
  # modelo de producto para el uso de turbo_stream_from
  ################################################################################
  def broadcast
    broadcast_replace_to self, partial: "products/product_details", locals: { product: self }
    # lo que realiza turbo es remplazar lo que tenemos para ello se debe usar el broadcast_replace_to
    # en este pasamo el self que seria algo como product_id
  end
  ################################################################################
  # SE HIZO UN CONCERN PARA OPTIMIZAR EL CODIGO LLAMADO FAVORITETABLE
  ################################################################################
  # relacion de favoritos de uno a muchos y si se borra el usuario que se borre todo
  # has_many :favorites,  dependent: :destroy
  # metodo de favoritos para el controllador de favoritescontroller
  # def favorite!
  #  favorites.create(user: Current.user)
  # end
  #
  # def unfavorite!
  # favorites.find_by(user: Current.user).destroy
  #  favorites.find_by(favorite).destroy # se optimizo mandando a llamar el metodo de abajo
  # end

  # metodo para la vista de show opteniendo los resultados de favoritos
  # def favorite
  #  favorites.find_by(user: Current.user)
  # end
  ################################################################################
  # FINAL DE LA TABLE DE FAVORITE
  ################################################################################
end
