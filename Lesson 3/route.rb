require_relative('instance_counter')

class Route
  include InstanceCounter
  attr_reader :stations
  
  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
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
