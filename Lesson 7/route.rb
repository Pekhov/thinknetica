require_relative('instance_counter')
require_relative('station')

class Route
  include InstanceCounter
  attr_reader :stations

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
    true
  rescue
    false
  end

  protected

  def validate!
    raise "Станции должны быть заполнены" unless stations.all?
    raise "Станции должны быть объектами класса Station" unless stations.all?(Station)
    raise "Начальная и конечная станции должны отличаться!" if stations.uniq.size < 2
  end
end
