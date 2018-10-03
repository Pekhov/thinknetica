require_relative('wagon')

class CargoWagon < Wagon
  
  def initialize(volume)
    super('cargo', volume)
  end

end
