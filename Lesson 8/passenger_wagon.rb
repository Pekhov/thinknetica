require_relative('wagon')

class PassengerWagon < Wagon
  attr_reader :free_place
  
  def initialize(sitting_place)
    @all_sitting_place = (0...sitting_place).to_a
    @free_place = (0...sitting_place).to_a
    super('passenger')
  end
  
  def take_sitting_place
    if @free_place.size.positive?
      @free_place.pop
    else
      false
    end
  end
  
  def get_busy_place
    (@all_sitting_place - @free_place).size
  end
  
  def get_free_place
    @free_place.size
  end

end
