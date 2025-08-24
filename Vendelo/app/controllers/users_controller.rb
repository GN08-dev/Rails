class UsersController < ApplicationController
  skip_before_action :protect_pages, only: [ :show ]
  def show
    # el simbolo colocado por ! es para mandar una excepcion para ecitar el que carge lo demas
    @user = User.find_by!(username: params[:username])
    # se quito porque se hace uso de los tags de turbo
    # @pagy, @products = pagy_countless(FindProducts.new.call(user_id: @user.id).load_async, item: 12)
  end
  # url para listar mis productos
  # http://127.0.0.1:3000/user/emilio
end
