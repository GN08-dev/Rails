class Current < ActiveSupport::CurrentAttributes
  # cuardamos los atributos del usuario informacion para hacer accepsible en cualquier lugar
  attribute :user # se puede guardar mas cosas como ips o el tipo de navegador
end
