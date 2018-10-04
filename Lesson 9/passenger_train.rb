class PassengerTrain < Train
  def initialize(number)
    super(number, 'passenger')
  end

  def can_attach_wagon?(wagon)
    wagon.instance_of?(PassengerWagon)
  end
end
