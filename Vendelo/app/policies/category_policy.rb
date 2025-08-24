class CategoryPolicy < BasePolicy
  def method_missing(m, *args, &block)
    Current.user&.admin?
  end
end

=begin
forma mas simplificar lo que es escribir todos los metodos a ocupar
lo que hace es que sobrescribe lo que esta base_plicy a categgory_police
def method_missing(m, *args, &block)
    Current.user&.admin?
end




def index
    Current.user&.admin?
  end
  def new
    Current.user&.admin?
  end
  def show
    Current.user&.admin?
  end
  def create
    Current.user&.admin?
  end
  def destroy
    Current.user&.admin?
  end
=end
