class Product < ApplicationRecord
  #se agrego pg_search para que funcione en la busqeuda siempre se coloca en el modelo 
  include PgSearch::Model
  pg_search_scope :search_full_text, against: {
    title: 'A',
    descripcion: 'B',
    #price: 'C'
  }
  #declaracion de constante
  ORDER_BY = {
      newest: "created_at DESC",
      expensive: "price DESC",
      cheaper: "price asc",
    }
  # las prioridades son de a b c
  #archivos adjuntos para el guardado de imagenes
  # se le coloca que es una foto por convencion si es para un usuario podria ser con un nombre definido de avatar
  has_one_attached  :photo 

  # modelo para visualizar los datos
  # validacion de datos 
  validates :title, presence: true
  validates :descripcion, presence: true
  validates :price, presence: true

  belongs_to :category
end
