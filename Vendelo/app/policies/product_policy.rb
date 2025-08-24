class ProductPolicy < BasePolicy
  # declaracion de metods
  def edit
    record.owner?
  end
  def update
    record.owner?
  end
  def destroy
    record.owner?
  end
end
# se obtimizo creando una funcion owner? en el modelo de products
# record.user_id == Current.user.id
