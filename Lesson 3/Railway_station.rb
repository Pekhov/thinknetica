class Station
  attr_reader :name, :trains
  
  def initialize(name)
    @name = name
    @trains = []
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

end

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

class Train
  attr_reader :number, :type, :speed, :car_number
  
  def initialize(number, type, car_number)
    @number = number
    @type = type
    @car_number = car_number
    @speed = 0
  end
  
  def increase_speed(speed)
    @speed += speed
  end
  
  def decrease_speed(speed)
    @speed -= speed if @speed >= speed
  end
  
  def add_car
    @car_number += 1 if @speed == 0
  end
  
  def remove_car
    @car_number -= 1 if @speed == 0 && @car_number > 0
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
    if @current_station > 0
      @route.stations[@current_station - 1]
    end
  end
  
  def go_to_next_station
    if next_station
      current_station.train_departure(self)
      @current_station += 1
      current_station.add_train(self)
    end
  end
  
  def go_to_previous_station
    if @current_station > 0
      current_station.train_departure(self)
      @current_station -= 1
      current_station.add_train(self)
    end
  end


end

station1 = Station.new("StartStationName")
station2 = Station.new("EndStationName")
station3 = Station.new("MiddleStationName")
route = Route.new(station1, station2)
route.add_station(station3)
route.delete_station(station3)
route.show_stations
train = Train.new(777, 'passenger', 3)
train2 = Train.new(888, 'freight_train', 3)
train.set_route(route)
puts "Speed: #{train.speed}"
train.increase_speed(50)
train.decrease_speed(10)
puts "Speed: #{train.speed}"
train.add_car
puts "Car number: #{train.car_number}"
puts train.current_station.name
train.go_to_next_station
train.go_to_next_station
puts train.current_station.name
train.go_to_previous_station
train2.set_route(route)
station1.add_train(train)
station1.add_train(train2)
puts station1.get_trains_in_station_by_type('passenger')
station1.train_departure(train)
puts station1.get_trains_in_station_by_type('passenger')
