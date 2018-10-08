require_relative('wagon')
require_relative('validation')

class PassengerWagon < Wagon
  attr_reader :free_place
  include Validation
  validate :type, :presence
  validate :free_place, :presence

  def initialize(sitting_place)
    super('passenger', sitting_place)
  end

  def take_place
    super(1)
  end
end
