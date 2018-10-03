require_relative('company_name')

class Wagon
  include CompanyName
  attr_reader :type
  WAGON_TYPE = ['cargo','passenger']

  def initialize(type, place_value)
    @type = type
    @all_place = place_value
    @free_place = place_value
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
  end
  
  def take_place(place_value = 1)
    @free_place -= place_value if @free_place.positive? and @free_place >= place_value
  end
  
  def busy_place
    @all_place - @free_place
  end

  def free_place
    @free_place
  end

  protected

  def validate!
    raise "Неверный тип поезда" unless WAGON_TYPE.include?(type)
  end
end
