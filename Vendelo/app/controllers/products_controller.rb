class ProductsController < ApplicationController
  # evitar el redireccionamiento de bucle de validacion de inicio de session de appplication controller del metodo protect_pages
  skip_before_action :protect_pages, only: [ :index, :show ]
  def index
    @categories = Category.all.order(name: :asc).load_async
      # uso de pagy para las paginas
      # se cambio el params por default por uno permitido
      params[:page] = params[:page].presence || 1
      @pagy, @products = pagy_countless(FindProducts.new.call(product_params_index).load_async, items: 12)
    # @pagy, @products = pagy_countless(FindProducts.new.call(params).load_async, items: 12)
  end

  def show
    # capturamos el id mediante los parametros que enviamso
    # find se usa para realizar una busqueda y le pasamos que buscamos en este caso el id
    # @product = Product.find(params[:id])
    product
  end

  def new
    @product =  Product.new
  end

  def create
    # forma base de creacion
    # @product = Product.new(producto_params)
    # pp @product

    # forma de creacion con asignacion de usuario
    # @product = Current.user.products.new(producto_params)
    # forma recomendada en directamente en el modelo pasarle un valor por default mejor

    @product = Product.new(producto_params)

    if @product.save
      # despues del redirect se agrego la noticia que se agrego correctamente el producto
      redirect_to products_path, notice: t(".created")

    else
      # lo que se coloca despues del new es para que devuelva un error 442
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # consulta para encontrar el id
    # @product = Product.find(params[:id])
    # consulta policies para saber si es el usuario de que va a editar
    # authorize!(product) forma 1
    authorize! product
    # product
  end

  def update
    authorize! product
    # aqui tambien se puede usar el metodo product
    @product =  Product.find(params[:id]) # consulta a buscar por id

    if @product.update(producto_params) # le pasamos los parametros que deceamos actualizar
      redirect_to products_path,  notice: t(".updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # eliminar producto
  def destroy
    authorize! product
    # se cambio por la funcion de product para hacer mas limpio el codigo
    # @product = Product.find(params[:id])
    # @product.destroy
    product.destroy
    # le pasamos un estatus de 303 para que funcione con turbo el metodo delete
    redirect_to products_path, notice: t(".destroyed"), status: :see_other
  end

  private

  def producto_params
    params.require(:product).permit(:title, :descripcion, :price, :photo, :category_id)
  end

  def product
    @product ||= Product.find(params[:id]) # devuelve la busqueda
  end

  def product_params_index
    params.permit(:category_id, :min_price, :max_price, :query_text, :order_by, :page, :favorites, :user_id)
  end






  # es el index original antes de la refactorizacion de codigo en el index
  def index_pruebas
    # filtrado por categorias
    @categories = Category.all.order(name: :asc).load_async # para que carge de manera asinctrona
    # aqui realiza dos peticiones simultaneas para evitar que se realice varias peticiones se le agregara despues del all un attached
    # @products = Product.all
    # @products = Product.all.with_attached_photo.order(created_at: :desc).load_async
    # se cambio categorias para pasar el orden de otra forma y la forma sync tambien
    @products = Product.with_attached_photo

    # filtrado de informacion por medio de una url
    if params[:category_id]
      @products = @products.where(category_id: params[:category_id])
    end
    # para el filtrado por precios
    if params[:min_price].present? # el present es para saber si tiene algun valor
      # se hace dinamico cuando le decimos a la consulta que sera ? un valor dinamico y le pasamos elvalor
      @products = @products.where("price >= ? ", params[:min_price])
    end
    if params[:max_price].present?
      @products = @products.where("price <= ?", params[:max_price])
    end
    # filtrado por texto por pg_search
    if params[:query_text].present?
      @products = @products.search_full_text(params[:query_text])
    end
    # order_by = {
    # newest: "created_at DESC",
    #  expensive: "price DESC",
    #  cheaper: "price asc",
    # }.fetch(params[:order_by]&.to_sym, "created_at DESC")
    # SE DECLARO EN EL MODELO EL ORDER BY
    order_by = Product::ORDER_BY.fetch(params[:order_by]&.to_sym, Product::ORDER_BY[:newest])
    @products= @products.order(order_by).load_async

      # uso de pagy para las paginas
      params[:page] = params[:page].presence || 1
      @pagy, @products = pagy_countless(@products, items: 12)
      pp(@pagy)
  end
end
