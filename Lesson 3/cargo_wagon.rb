require_relative('wagon')

class CargoWagon < Wagon
  
  def initialize
    @type = 'cargo'
    super(@type)
  end

end
