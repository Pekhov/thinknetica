require_relative('train')

class CargoTrain < Train
  
  def initialize(number, type = 'cargo_train')
    super
  end

  def can_attach_wagon?(wagon)
    wagon.instance_of?(CargoWagon)
  end
end
