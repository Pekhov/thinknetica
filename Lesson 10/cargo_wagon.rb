require_relative('wagon')
require_relative('validation')

class CargoWagon < Wagon
  include Validation
  validate :type, :presence

  def initialize(volume)
    super('cargo', volume)
  end

end
