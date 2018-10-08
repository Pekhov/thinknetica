require_relative('train')
require_relative('validation')

class CargoTrain < Train
  include Validation
  validate :number, :presence

  def initialize(number)
    super(number, 'cargo_train')
  end

  def can_attach_wagon?(wagon)
    wagon.instance_of?(CargoWagon)
  end
end
