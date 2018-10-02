require_relative('train')

class CargoTrain < Train
  
  def initialize(number)
    super(number, 'cargo_train')
  end

  def can_attach_wagon?(wagon)
    wagon.instance_of?(CargoWagon)
  end
end
