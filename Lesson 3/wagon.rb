require_relative('company_name')

class Wagon
  include CompanyName
  attr_reader :type
  
  def initialize(type)
    @type = type
  end
end
