class Route
  attr_reader :stations
  
  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
  end
  
  def show_stations
    @stations.each {|station| puts station.name}
  end
  
  def add_station(station)
    @stations.insert(-2, station)
  end
  
  def delete_station(station)
    @stations.delete(station) if @stations.values_at(1..-2).include?(station)
  end
end