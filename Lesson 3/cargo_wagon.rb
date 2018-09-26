require_relative('wagon')

class CargoWagon < Wagon
  
  def initialize(type = 'cargo')
    @type = type
  end

end
