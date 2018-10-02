require_relative('instance_counter')

class Station
  include InstanceCounter
  attr_reader :name, :trains
  STATION_NAME = /[а-яё]{3,}/i

  @@stations = []

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
    @trains.count {|train| train.type == type}
  end

  def train_departure(train)
    @trains.delete(train) if train.current_station == self
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def train_to_block
    self.trains.each {|train| yield(train)}
  end

  protected

  def validate!
    raise "Имя станции должно быть указано" if name.nil?
    raise "Неверный формат имени станции" if name !~ STATION_NAME
  end

end
