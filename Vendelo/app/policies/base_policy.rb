# clase padre de las policies
class BasePolicy
  attr_reader :record
  def initialize(record)
    @record = record
  end

  # si no se encuentra un metodo dentro de la polici no marque erro y se quede ciclado en dado caso que un metodo no exista

  def method_missing(m, *args, &block)
    false
  end
end
