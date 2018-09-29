require_relative('instance_counter')

class Station
  include InstanceCounter
  attr_reader :name, :trains
  STATION_NAME = /[а-яеё]{3,}/i

  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    validate!
  end

  def self.all_stations
    @@stations
  end

  def add_train(train)
    @trains << train
  end

  def get_trains_in_station_by_type(type)
    @trains.count {|train| train.type == type}
  end

  def train_departure(train)
    @trains.delete(train) if train.current_station == self
  end

  def valid?
    validate!
  rescue
    false
  end

  protected

  def validate!
    raise "Неверный формат имени станции" if self.name !~ STATION_NAME
    true
  end

end
