require_relative('wagon')
require_relative('company_name')
require_relative('instance_counter')
require_relative('validation')

class Train
  include CompanyName
  include InstanceCounter
  include Validation

  attr_reader :number, :type, :speed, :wagons, :route
  TRAIN_TYPE = %w[cargo_train passenger].freeze
  TRAIN_NUMBER = /^\w{3}-*\w{2}$/i
  @@trains = {}

  validate :number, :format, format: TRAIN_NUMBER
  validate :number, :presence
  validate :type, :presence

  def initialize(number, type)
    @number = number
    @type = type
    validate!
    @@trains[number] = self
    @wagons = []
    @speed = 0
  end

  def self.find(number)
    @@trains[number]
  end

  def increase_speed(speed)
    @speed += speed
  end

  def decrease_speed(speed)
    @speed -= speed if @speed >= speed
  end

  def set_route(route)
    @route           = route
    @current_station = 0
    route.stations.first.add_train(self)
  end

  def current_station
    @route.stations[@current_station]
  end

  def next_station
    @route.stations[@current_station + 1]
  end

  def previous_station
    @route.stations[@current_station - 1] if @current_station > 0
  end

  def go_to_next_station
    return unless next_station

    current_station.train_departure(self)
    @current_station += 1
    current_station.add_train(self)
  end

  def go_to_previous_station
    return if @current_station.negative?

    current_station.train_departure(self)
    @current_station -= 1
    current_station.add_train(self)
  end

  def add_wagon(wagon)
    wagons << wagon if can_attach_wagon?(wagon)
  end

  def remove_wagon(wagon)
    wagons.delete(wagon) if speed.zero? && wagons.size.positive?
  end

  def each_wagon
    wagons.each { |wagon| yield(wagon) }
  end

end
