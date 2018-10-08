require_relative('validation')

class PassengerTrain < Train
  include Validation
  validate :number, :presence

  def initialize(number)
    super(number, 'passenger')
  end

  def can_attach_wagon?(wagon)
    wagon.instance_of?(PassengerWagon)
  end
end
