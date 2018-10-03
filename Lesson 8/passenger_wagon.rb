require_relative('wagon')

class PassengerWagon < Wagon
  attr_reader :free_place
  
  def initialize(sitting_place)
    super('passenger', sitting_place)
  end

end
