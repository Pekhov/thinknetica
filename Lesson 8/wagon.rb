require_relative('company_name')

class Wagon
  include CompanyName
  attr_reader :type
  WAGON_TYPE = ['cargo','passenger']

  def initialize(type)
    @type = type
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise "Неверный тип поезда" unless WAGON_TYPE.include?(type)
  end
end
