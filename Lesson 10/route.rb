require_relative('instance_counter')
require_relative('station')
require_relative('validation')
require_relative('accessors')

class Route
  include InstanceCounter
  include Validation
  extend Accessors

  attr_accessor_with_history :stations, :start_station, :end_station

  validate :start_station, :presence
  validate :end_station, :presence
  validate :start_station, :type, class: Station
  validate :end_station, :type, class: Station

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
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

end
