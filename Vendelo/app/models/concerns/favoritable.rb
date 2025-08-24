module Favoritable
  extend ActiveSupport::Concern
  included do
    # relacion de favoritos de uno a muchos y si se borra el usuario que se borre todo
    has_many :favorites,  dependent: :destroy

    # metodo de favoritos para el controllador de favoritescontroller
    def favorite!
      favorites.create(user: Current.user)
    end

    def unfavorite!
      # favorites.find_by(user: Current.user).destroy
      favorite.destroy # se optimizo mandando a llamar el metodo de abajo
    end
    # metodo para la vista de show opteniendo los resultados de favoritos
    def favorite
      favorites.find_by(user: Current.user)
    end
  end
end
