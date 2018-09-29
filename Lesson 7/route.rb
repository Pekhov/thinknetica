require_relative('instance_counter')

class Route
  include InstanceCounter
  attr_reader :stations
  STATION_NAME = /[а-яеё]{3,}/i
  
  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    validate!
  end
  
  def show_stations
    @stations.each.with_index(1) do |station, index|
      puts "#{index} - #{station.name}"
    end
  end
  
  def add_station(station)
    @stations.insert(-2, station)
  end
  
  def delete_station(station)
    @stations.delete(station) if @stations.values_at(1..-2).include?(station)
  end

  def valid?
    validate!
  rescue
    false
  end

  protected

  def validate!
    raise "Неверный формат имени станции" if self.stations.select{|station| station !~ STATION_NAME}.any?
    true
  end
end
