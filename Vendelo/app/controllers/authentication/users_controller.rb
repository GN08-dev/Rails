class Authentication::UsersController <ApplicationController
  # evitar el redireccionamiento de bucle de validacion de inicio de session de appplication controller del metodo protect_pages
  skip_before_action :protect_pages
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # guardar la session por medio de una cookie pero esta encriptado
      session[:user_id] = @user.id
      redirect_to products_path, notice: t(".created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def user_params
    # solicitamos que traiga el primer parametro llamado user de lo contrario no lo toma
    params.require(:user).permit(:email, :username, :password)
  end
end
