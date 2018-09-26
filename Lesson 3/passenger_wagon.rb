require_relative('wagon')

class PassengerWagon < Wagon
  
  def initialize
    @type = 'passenger'
    super(@type)
  end

end
