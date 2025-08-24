class FavoritesController < ApplicationController
  def index
  end
  def create
    # Favorite.create(product: product, user: Current.user)
    product.favorite!
    # se cambiara a otro tipo de formato porque redirect_to manda un tipo html y ocupamos un string para usarlo con turbo
    respond_to do |format|
      format.html do
        redirect_to product_path(product)
      end
=begin
en este caso lo que hace turbo_strem.remplace es buscar un div con el id que le pasemos y lo remplace
o mejor dicho que lo sobre escriba el contenido que tenga dentro
lo que hace locals: { product: product } es actualizar el producto de favorite en create
=end
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("favorite", partial: "products/favorite", locals: { product: product })
      end
    end
  end

  def destroy
    product.unfavorite!
    respond_to do |format|
      format.html do
        redirect_to product_path(product), status: :see_other
      end
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("favorite", partial: "products/favorite", locals: { product: product })
      end
    end
  end
  # en dado caso que no exista no se crearia
  private
  # memorizarion usando la forma de cachar la consulta
  def product
   # se debera refirir siempre al metodo que debera tener el mismo nombre
   # SE HACE CON EL FIN DE EVIAR CONSULTAS REPETITIVAS
   @product ||=  Product.find(params[:product_id])
  end
end
