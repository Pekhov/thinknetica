require_relative('company_name')
require_relative('validation')

class Wagon
  include CompanyName
  include Validation

  attr_reader :type, :free_place
  WAGON_TYPE = %w[cargo passenger].freeze

  validate :type, :presence

  def initialize(type, place_value)
    @type = type
    @all_place = place_value
    @free_place = place_value
    validate!
  end

  def take_place(place_value)
    @free_place -= place_value if @free_place >= place_value
  end

  def busy_place
    @all_place - @free_place
  end

end
