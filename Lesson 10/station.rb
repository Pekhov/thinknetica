require_relative('instance_counter')
require_relative('validation')
require_relative('accessors')

class Station
  include InstanceCounter
  include Validation
  extend Accessors

  attr_accessor_with_history :name, :trains
  STATION_NAME = /[а-яё]{3,}/i

  @@stations = []

  validate :name, :presence
  validate :name, :format, regexp: STATION_NAME

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations << self
  end

  def self.all_stations
    @@stations
  end

  def add_train(train)
    @trains << train
  end

  def get_trains_in_station_by_type(type)
    @trains.count { |train| train.type == type }
  end

  def train_departure(train)
    @trains.delete(train) if train.current_station == self
  end

  def each_train
    trains.each { |train| yield(train) }
  end

end
