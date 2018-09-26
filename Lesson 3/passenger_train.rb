
class PassengerTrain < Train
  
  def initialize(number)
    @type = 'passenger'
    super(number, @type)
  end
  
  def can_attach_wagon?(wagon)
    wagon.instance_of?(PassengerWagon)
  end
end
